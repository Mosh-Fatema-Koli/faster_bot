import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/chat/chat_detalis.dart';
import 'package:wow_chat_app/src/screen/tab/controller/unread_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/hex_color.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/service/helper/Prefs_helper.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../service/controller/audio_sound.dart';
import '../../service/helper/socket_helper.dart';

class UnreadChatPage extends StatefulWidget {
  const UnreadChatPage({super.key});

  @override
  State<UnreadChatPage> createState() => _UnreadChatPageState();
}

class _UnreadChatPageState extends State<UnreadChatPage> {
  final _controller = Get.put(UnreadController());
  final audioController = Get.put(AudioPlayerController());

  var tenantId="";

  @override
  void initState(){
    _controller.scrollController=ScrollController();
    _controller.fastLoad(true);
    _controller.scrollController.addListener(() {
      if (_controller.scrollController.position.pixels ==
          _controller.scrollController.position.maxScrollExtent) {
        _controller.loadMore();
      }
    });
    getTenantId();
    super.initState();
  }

  getTenantId()async{
    tenantId= await PrefsHelper.getString(AppConstants.tenantId);
    await disposeListen();
    await receivedListen();
  }
  receivedListen()async{
    print('======> Received data on Screen all chat listen');
    var tenantId= await PrefsHelper.getString(AppConstants.tenantId);
    SocketApi.socket.on('APP::CHAT::THREAD::LIST::$tenantId',(data)
    {
      print('Received data on Screen All Chat: $data');
      _controller.fastLoad(false);
      audioController.playAudio();
    });
  }

  disposeListen()async{
    SocketApi.socket.off('APP::CHAT::THREAD::LIST::$tenantId');
    SocketApi.socket.dispose();
    SocketApi.socket.disconnect().connect();
    debugPrint('======> Received data on Screen all chat listen Dispose');
  }

  @override
  void dispose() {
    _controller.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => _controller.isFirstLoadRunning.value
            ? const Center(
          child: CircularProgressIndicator(color: BrandColors.colorButton,),
        ):_controller.unreadList.isEmpty? Center(child: KText(text: "No Chat Available",),)
            :
               ListView.separated(
                  itemCount: _controller.unreadList.length+1,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                    controller: _controller.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index < _controller.unreadList.length) {
                      var data = _controller.unreadList[index];
                      return ListTile(
                        contentPadding: EdgeInsets.all(8),
                        onTap: (() {
                          //    Get.to(ChatDtlsPage(listElement: data,));

                          Get.toNamed(chatDetailsScreen, arguments: data);
                        }),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueGrey,
                          backgroundImage: NetworkImage(
                              "${AppConstants.socketBaseUrl}/images/${data.telegramUserId!.photo??""}"),
                        ),
                        title: KText(
                            text:
                                "${data.telegramUserId!.firstName??""} ${data.telegramUserId!.lastName??""}",
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        subtitle: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if( data.label != null && data.label!.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: BrandColors.colorButton,
                                        width: 0.5,
                                        style: BorderStyle.solid)),
                                child: KText(
                                  text: data.label,
                                  fontSize: 10,
                                ),
                              ),

                            SizedBox(
                              height: 5,
                            ),

                            Row(
                              children: [
                                data.lastMessage == "photo"
                                    ? const Icon(
                                        Icons.image,
                                        size: 15,
                                      )
                                    : data.lastMessageBy == "Bot"
                                        ? KText(
                                            text: "You : ",
                                            color: BrandColors.greyColor,
                                            fontSize: 10.sp,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : const Icon(
                                            Icons.textsms_outlined,
                                            size: 15,
                                          ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                    child: data.lastMessage == "photo"
                                        ? KText(
                                            text: data.lastMessageBy == "Bot"
                                                ? "You senta photo"
                                                : "Photo",
                                            color: BrandColors.greyColor,
                                            fontSize: 10.sp,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : KText(
                                            text: data.lastMessage,
                                            color: BrandColors.greyColor,
                                            fontSize: 10.sp,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )),
                              ],
                            ),
                          ],
                        ),
                        trailing: KText(
                          text: timeago.format(data.lastMessageAt!),
                          color: BrandColors.greyColor,
                          fontSize: 10.sp,
                        ),
                      );
                    } else {
                      if (_controller.isLoadMoreRunning.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const SizedBox();
                      }
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 10,
                    );
                  },
                ),

      ),
      // floatingActionButton:FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   onPressed: (){
      //
      //   },
      //   child: Icon(Icons.mark_unread_chat_alt),
      // ),
    );
  }
}
