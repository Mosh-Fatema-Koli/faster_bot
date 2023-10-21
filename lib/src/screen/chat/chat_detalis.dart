import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wow_chat_app/src/screen/block/controller/block_controller.dart';
import 'package:wow_chat_app/src/screen/chat/controller/audio_controller.dart';
import 'package:wow_chat_app/src/screen/chat/controller/camera_controller.dart';
import 'package:wow_chat_app/src/screen/chat/controller/chat_controller.dart';
import 'package:wow_chat_app/src/screen/chat/image_view.dart';
import 'package:wow_chat_app/src/screen/label/label_controller.dart';
import 'package:wow_chat_app/src/screen/tab/model/unread_chat_model.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import '../../service/helper/socket_helper.dart';
import '../../service/utils/app_constent.dart';
import 'model/unread_chat_details_model.dart';


class ChatDtlsPage extends StatefulWidget {
  const ChatDtlsPage({
    super.key,
  });

  @override
  State<ChatDtlsPage> createState() => _ChatDtlsPageState();
}

class _ChatDtlsPageState extends State<ChatDtlsPage> {



  ListElement userData = Get.arguments;
  
  RxBool isRecording= false.obs;

  final ImageController imgcontroller = Get.put(ImageController());

  final ChatDController _controller = Get.put(ChatDController());

  final BlockController _blockController = Get.put(BlockController());

  final LabelController _labelController = Get.put(LabelController());

  final AudioController audioController = Get.put(AudioController());


  @override
  void initState() {

    _controller.scrollController = ScrollController(initialScrollOffset: 0.0);
    _controller.fastLoad(userData.id!);
    _controller.scrollController.addListener(() {
      if (_controller.scrollController.position.pixels ==
          _controller.scrollController.position.minScrollExtent) {
        print("====> scroll Top");
        // _controller.loadMore(userData.id);
      }else if (_controller.scrollController.position.pixels ==
          _controller.scrollController.position.maxScrollExtent){
        print("====> scroll bottom");
        _controller.loadMore(userData.id!);
      }
    });
    _controller.receivedListen(userData.id!);

    super.initState();
    reset();
  }




  @override
  void dispose() {
    _controller.scrollController.dispose();
    SocketApi.socket.off('APP::CHAT::NEW::${userData.id}');
  //  SocketApi.socket.dispose();
 //  SocketApi.socket.disconnect().connect();

    super.dispose();
  }

  static const styleSender = BubbleStyle(
    margin: BubbleEdges.only(bottom: 10),
    alignment: Alignment.topRight,
    radius: Radius.circular(10),
    nip: BubbleNip.rightTop,
    color: Color.fromRGBO(236, 180, 186, 1.0),
  );

  static const styleRecever = BubbleStyle(
    margin: BubbleEdges.only(bottom: 10),
    radius: Radius.circular(10),
    alignment: Alignment.topLeft,
    nip: BubbleNip.leftTop,
  );

  Rx<ListElement> data = ListElement().obs;




  static const countdownDuration = Duration(minutes: 10);
  Duration duration = Duration();
  Timer? timer;

  bool countDown =true;



  void reset(){
    if (countDown){
      setState(() =>
      duration = countdownDuration);
    } else{
      setState(() =>
      duration = Duration());
    }
  }

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_) => addTime());
  }

  void addTime(){
    final addSeconds = countDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0){
        timer?.cancel();
      } else{
        duration = Duration(seconds: seconds);

      }
    });
  }

  void stopTimer({bool resets = true}){
    if (resets){
      reset();
    }
    setState(() => timer?.cancel());
  }



  @override
  Widget build(BuildContext context) {
    data.value = userData;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Obx(()=>
             Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => _controller.isFirstLoadRunning.value
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: BrandColors.colorButton,
                            ),
                          ),
                        )
                      : Flexible(
                              child: NotificationListener<ScrollNotification>(
                              onNotification:(scrollNotification){
                                if (scrollNotification is ScrollStartNotification) {
                                  // Scroll started
                                } else if (scrollNotification is ScrollUpdateNotification) {
                                  // Scrolling is ongoing
                                } else if (scrollNotification is ScrollEndNotification) {
                                  // Scroll ended
                                }
                                if (scrollNotification.metrics.atEdge) {
                                  // if (scrollNotification.metrics.pixels == 0) {
                                  //   // Scrolled to the top
                                  //   print('Scrolled to the top');
                                  // } else if (scrollNotification.metrics.pixels ==
                                  //     scrollNotification.metrics.maxScrollExtent) {
                                  //   // Scrolled to the bottom
                                  //   print('Scrolled to the bottom');
                                  // }
                                }
                                return false; // Retur

                              },
                            child: GroupedListView<ChatDetailsModel, DateTime>(
                              elements: _controller.chatList.value,
                              controller: _controller.scrollController,
                              order: GroupedListOrder.DESC,
                              itemComparator: (item1, item2) =>
                                  item1.originalTimestamp!.compareTo(item2.originalTimestamp!),
                              groupBy: (ChatDetailsModel message) => DateTime(
                                  message.originalTimestamp!.year,
                                  message.originalTimestamp!.month,
                                  message.originalTimestamp!.day),
                              reverse: true,
                              groupSeparatorBuilder: (DateTime date) {
                                final now = DateTime.now();
                                final today =
                                    DateTime(now.year, now.month, now.day);
                                return Center(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 5),
                                                spreadRadius: 0,
                                                blurRadius: 5,
                                                color: Colors.black
                                                    .withOpacity(0.15))
                                          ]),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 3.h),
                                      margin: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                      ),
                                      child: today == date
                                          ? const Text("Today")
                                          : Text(
                                              DateFormat('MMMM dd, yyyy')
                                                  .format(date),
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                color: Colors.grey.shade700,
                                              ),
                                            )),
                                );
                              },

                              itemBuilder: (context, ChatDetailsModel message) {
                                return Row(
                                  mainAxisAlignment: message.sender == "User"
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (message.sender == "User")
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Padding(
                                        //   padding: const EdgeInsets.only(left:15),
                                        //   child: Text(dateTime.format(DateTimeFormats.american),style: TextStyle(color: Colors.grey.withOpacity(0.5),fontSize:10.sp),),
                                        // ),
                                        SizedBox(
                                          width: Get.width / 1.3,
                                          child: Bubble(
                                            style: message.sender == "User"
                                                ? styleRecever
                                                : styleSender,
                                            child: message.content!.kind == "text" ? Column(
                                                    crossAxisAlignment:
                                                        message.sender != "User"
                                                            ? CrossAxisAlignment
                                                                .end
                                                            : CrossAxisAlignment
                                                                .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Flexible(
                                                        child:SelectableText(
                                                          message.content!.data!.text,style:TextStyle(fontSize: 16.sp,
                                                        ),

                                                        ),
                                                      //     child: KText(
                                                      //   text: message
                                                      //       .content!.data!.text,
                                                      // )
                                                      ),
                                                      // SizedBox(
                                                      //   width: 5.w,
                                                      // ),
                                                      Text(
                                                        DateFormat('h:mm a')
                                                            .format(message
                                                                .originalTimestamp!),
                                                        style: TextStyle(
                                                            fontSize: 10.sp,
                                                            color: Colors
                                                                .grey.shade700),
                                                      )
                                                    ],
                                                  ):
                                            message.content!.kind == "photo"? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(ImageViewPage(
                                                              images: message
                                                                  .content!
                                                                  .data!
                                                                  .file
                                                                  .toString()));
                                                        },
                                                        child:message.sId==null?Container(
                                                          height: 150.h,
                                                          width: 150.w,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .grey
                                                                  .shade300,
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  10)),
                                                          child: ClipRRect(
                                                                 borderRadius: BorderRadius.circular(10),
                                                              child: Image.file(File(message.content!.data!.file!),fit: BoxFit.cover,)),):

                                                        CachedNetworkImage(
                                                          imageUrl: message
                                                                  .content!
                                                                  .data!
                                                                  .file
                                                                  .toString()
                                                                  .startsWith(
                                                                      "https://")
                                                              ? "${message.content!.data!.file}"
                                                              : "https://engine.fasterbot.net/images${message.content!.data!.file}",
                                                          imageBuilder: (context,
                                                                  imageProvider) =>
                                                              Stack(
                                                            children: [
                                                              Container(
                                                                height: 150.h,
                                                                width: 150.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  image:
                                                                      DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              if (message
                                                                      .content!
                                                                      .data!
                                                                      .text ==
                                                                  null)
                                                                Positioned(
                                                                    bottom: 3.w,
                                                                    right: 3.w,
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .black38,
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                offset: const Offset(0, 5),
                                                                                spreadRadius: 0,
                                                                                blurRadius: 5,
                                                                                color: Colors.black.withOpacity(0.15))
                                                                          ]),
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              5.w,
                                                                          vertical:
                                                                              3.h),
                                                                      child: Text(
                                                                        DateFormat(
                                                                                'h:mm a')
                                                                            .format(
                                                                                message.originalTimestamp!),
                                                                        style: TextStyle(
                                                                            fontSize: 11
                                                                                .sp,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ))
                                                            ],
                                                          ),
                                                          placeholder: (context,
                                                                  url) =>
                                                              Shimmer.fromColors(
                                                            baseColor: Colors.grey
                                                                .withOpacity(0.2),
                                                            highlightColor: Colors
                                                                .grey
                                                                .withOpacity(
                                                                    0.25),
                                                            child: Container(
                                                              height: 150.h,
                                                              width: 150.w,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10)),
                                                            ),
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                                  height: 150.h,
                                                                  width: 150.w,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade300,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child:
                                                                      const Center(
                                                                          child:
                                                                              Icon(
                                                                    Icons.error,
                                                                    color: Colors
                                                                        .red,
                                                                  ))),
                                                        ),
                                                      ),
                                                      if (message.content!.data!
                                                              .text !=
                                                          null)
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                      if (message.content!.data!
                                                              .text !=
                                                          null)
                                                        SizedBox(
                                                          width: 150.w,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  message.content!
                                                                      .data!.text,
                                                                ),
                                                              ),
                                                              Text(
                                                                DateFormat(
                                                                        'h:mm a')
                                                                    .format(message
                                                                        .originalTimestamp!),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11.sp,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                    ],
                                                  )
                                                : _audio(message:'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba-online-audio-converter.com_-1.wav', isCurrentUser:true, index: 1, )
                                            ,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),

                ),
                data.value.status == "Blocked" ? _blocked() : _sendMessageSection()
              ],
            ),
          ),
          Positioned(
              top: 10,
              child: Obx(() => _controller.isLoadMoreRunning.value
                  ? const CircularProgressIndicator(
                      color: BrandColors.colorButton,
                    )
                  : const SizedBox()))
        ],
      ),
    );
  }

  _blocked() {
    return Container(

      child: Column(
        children: [
          GestureDetector(
            onTap: ()async{
              var result= _blockController.addUnBlock(data.value.id!, data.value.telegramUserId!.firstName!, data.value.telegramUserId!.lastName!);
              if(result.runtimeType != int){
                data.value.status="Active";
                data.refresh();
              }

            },
            child:  Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
            child: Container(
                height:40,
                alignment: Alignment.center,

                width: double.infinity,
                child:const Text("Unblock",style:TextStyle(),),
              ),
            ),
          ),

        ],
      ),
    );
  }
  Widget _audio({
    required String message,
    required bool isCurrentUser,
    required int index,
    //  required String time,
    //  required String duration,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              audioController.onPressedPlayButton(index, message);
              // changeProg(duration: duration);
            },
            onSecondaryTap: () {

              //   audioController.completedPercentage.value = 0.0;
            },
            child: Obx(
                  () => (audioController.isRecordPlaying &&
                  audioController.currentId == index)
                  ? Icon(
                    Icons.pause,
                color: isCurrentUser ? Colors.white :Colors.orangeAccent.withOpacity(0.5),
              )
                  : Icon(
                Icons.play_arrow,
                color: isCurrentUser ? Colors.white : Colors.orangeAccent.withOpacity(0.5),
              ),
            ),
          ),
          Obx(
                () => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    // Text(audioController.completedPercentage.value.toString(),style: TextStyle(color: Colors.white),),
                    LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isCurrentUser ? Colors.white : Colors.orangeAccent.withOpacity(0.5),
                      ),
                      value: (audioController.isRecordPlaying &&
                          audioController.currentId == index)
                          ? audioController.completedPercentage.value
                          : audioController.totalDuration.value.toDouble(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
           // audioController.totalDuration.value.toString(),
            Duration(microseconds:audioController.totalDuration.value).toString().split('.')[0],
            style: TextStyle(
                fontSize: 12, color: isCurrentUser ? Colors.white : Colors.orangeAccent.withOpacity(0.5)),
          ),
        ],
      ),
    );
  }


  _sendMessageSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Obx(() {
                if (isRecording.value) {
                  // When recording is active, show stopwatch
                  return AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KText(text:  Duration(seconds: _controller.recordingTime.value).toString().split('.').first,color: BrandColors.greyColor,), // Display the stopwatch time
                        GestureDetector(
                          onTap: () {
                            isRecording.value = false;
                            _controller.deleteRecording();
                          },
                          child: const Icon(Icons.delete, size: 20),
                        ),
                      ],
                    ),
                  );
                } else {
                  // When not recording, show text input
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    alignment: Alignment.bottomCenter,
                    child: TextField(
                      onChanged: (v) {
                        if (v.isNotEmpty) {
                          _controller.isMassageEmpty.value = true;
                        } else {
                          _controller.isMassageEmpty.value = false;
                        }
                      },
                      controller: _controller.textController,
                      maxLines: 1,
                      minLines: 1,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),
                        ),
                        hintText: "Text message",
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.image),
                              onPressed: () async {
                                _controller.pickImage(userData.id!, userData.telegramUserId!.tgid!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
          Obx(() => _controller.isMassageEmpty.value || isRecording.value
              ? CircleAvatar(
            backgroundColor: BrandColors.colorButton,
            child: IconButton(
              icon: const Icon(
                Icons.send,
                size: 20,
                color: BrandColors.colorWhite,
              ),
              onPressed: () {

                if(_controller.isMassageEmpty.value){

                _controller.sendMessage(userData);
              }else{
                  print("voice*********************");
                  _controller.stopRecording();
                  isRecording.value = false;
                }
              }
            ),
          )
              : CircleAvatar(
            backgroundColor: BrandColors.colorButton,
            child: IconButton(
              icon: const Icon(Icons.mic, color: BrandColors.colorWhite),
              onPressed: () {
                if (_controller.isVoiceRecording.value) {

                } else {
                  _controller.startRecording();
                }
                isRecording.value = true;
              },
            ),
          )),
        ],
      ),
    );
  }


  // _sendMessageSection() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical:5.h,horizontal:10),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Card(
  //             elevation: 5,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(20.0),
  //             ),
  //
  //             child: Obx(() => isRecording.value? AnimatedContainer(
  //               duration: Duration(seconds: 1),
  //               curve: Curves.fastOutSlowIn,
  //               padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),child: Row(
  //              mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 KText(text: _controller.getFormattedTime()),
  //                 GestureDetector(onTap:(){
  //                   isRecording.value= false;
  //                   _controller.deleteRecording();
  //                 },
  //                   child: Icon(Icons.delete,size: 20,)),
  //               ],
  //             ),):
  //             Container(
  //                 padding: EdgeInsets.symmetric(horizontal: 5.w),
  //                 alignment: Alignment.bottomCenter,
  //                 child: TextField(
  //                   onChanged: (v) {
  //                     if (v.isNotEmpty) {
  //                       _controller.isMassageEmpty.value = true;
  //                     } else {
  //                       _controller.isMassageEmpty.value = false;
  //                     }
  //                   },
  //                   controller: _controller.textController,
  //                   maxLines:1,
  //                   minLines:1,
  //                   decoration: InputDecoration(
  //                       focusedBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(50),
  //                         borderSide: const BorderSide(color: Colors.white, width: 0.0),
  //                       ),
  //                       enabledBorder: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(50),
  //                         borderSide: const BorderSide(color: Colors.white, width: 0.0),
  //                       ),
  //                       hintText: "Text message",
  //                       suffixIcon: Row(
  //                         mainAxisAlignment:
  //                         MainAxisAlignment.spaceBetween, // added line
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           IconButton(
  //                               icon: const Icon(Icons.image),
  //                               onPressed: () async {
  //                                 _controller.pickImage(
  //                                     userData.id!, userData.telegramUserId!.tgid!);
  //                               }),
  //
  //                         ],
  //                       )),
  //                 ))),
  //           ),
  //         ),
  //         Obx(
  //               () => _controller.isMassageEmpty.value || isRecording.value
  //               ?
  //           CircleAvatar(
  //             backgroundColor: BrandColors.colorButton,
  //             child: IconButton(
  //
  //               icon: const Icon(Icons.send,size: 20,
  //                   color: BrandColors.colorWhite),
  //               onPressed: () {
  //
  //                 _controller.sendMessage(userData);
  //
  //               },
  //             ),
  //           ): CircleAvatar(
  //                 backgroundColor: BrandColors.colorButton,
  //             child: IconButton(
  //               icon: const Icon(Icons.mic,
  //                   color: BrandColors.colorWhite),
  //               onPressed: () {
  //                 if(_controller.isVoiceRecording.value){
  //                   _controller.stopRecording();
  //                 }else{
  //                   _controller.startRecording();
  //                 }
  //                 isRecording.value=true;
  //               },
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }




  _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: (){

              Get.back();
        },
      ),
      backgroundColor: BrandColors.colorButton,
      titleSpacing: 0.0,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueGrey,
            backgroundImage: NetworkImage(
                "${AppConstants.socketBaseUrl}/images/${data.value.telegramUserId!.photo}"),
          ),
          Flexible(
            child: Obx(()=>
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: KText(
                        text:"${data.value.telegramUserId!.firstName??""} ${data.value.telegramUserId!.lastName??""}",
                        fontSize: 16,
                        color: Colors.white,
                        overflow:TextOverflow.ellipsis,
                        maxLines: 1,
                        fontWeight: FontWeight.w600,
                      )),
                  if (data.value.label != null && data.value.label!.isNotEmpty)
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: BrandColors.colorWhite,
                                width: 0.5,
                                style: BorderStyle.solid)),
                        child:
                           KText(
                            text: data.value.label,
                            fontSize: 10,
                            color: BrandColors.colorWhite,
                          ),
                        ),
                      ),

                  // Padding(
                  //   padding: EdgeInsets.only(left: 6),
                  //   child: Text("Online"),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
      actions: [
        // IconButton(onPressed: (){}, icon: Icon(Icons.video_call,size: 25,)),
        // IconButton(onPressed: (){}, icon: Icon(Icons.call,size: 25,)),
           PopupMenuButton<String>(onSelected: (value) async {
            if (value == 'profile') {
              Get.toNamed(tanentProfile, arguments: userData);
            } else if (value == 'block') {

              if(data.value.status=="Active"){

                var result=  await _blockController.addBlock(
                    userData.id!,
                    userData.telegramUserId!.firstName??"",
                    userData.telegramUserId!.lastName??"");
                if(result== "Blocked"){
                  data.value.status= "Blocked";
                  data.refresh();
                  debugPrint("$result *********************************");
                }
              }else{
                var result= await _blockController.addUnBlock( userData.id!,
                    userData.telegramUserId!.firstName??"",
                    userData.telegramUserId!.lastName??"");
                if(result.runtimeType != int){
                  data.value.status="Active";
                  data.refresh();
                }
              }

            } else {
              if(data.value.label !=null){
                _labelController.labelTextController.text=data.value.label!;
              }

              Get.defaultDialog(
                titleStyle: TextStyle(fontSize: 14.sp),
                title: "Add label for user",
                //radius: 20,
                barrierDismissible: true,
                content: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller:_labelController.labelTextController,
                      )
                    ],
                  ),
                ),
                actions: [
                  Obx(()=>
                     TextButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: BrandColors.colorButton,
                          elevation: 0.0,
                          shadowColor: pinkColor,
                          foregroundColor: Colors.white),
                      onPressed: ()async{
                    var result= await  _labelController.setLabel(userData.id!);
                    if(result.runtimeType != int){
                      debugPrint("label update =====> $result");
                      data.value.label=result;
                      data.refresh();
                    }
                    },
                      child: _labelController.isLoading.value?const SizedBox(
                          height:15,
                          width:15,
                          child: CircularProgressIndicator(color: Colors.white,)):const Text(
                        'Add',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  TextButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        elevation: 0.0,
                        shadowColor: pinkColor,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }
          }, itemBuilder: (BuildContext context) {
            return  [
              PopupMenuItem(
                value: 'block',
                child: data.value.status=="Active"? const Text("Block"):const Text("Unblock"),
              ),
              const PopupMenuItem(
                value: 'level',
                child: Text("Add Label"),
              ),
              const PopupMenuItem(
                value: 'profile',
                child: Text("View Details"),
              )
            ];
          }),

      ],
    );
  }
}
