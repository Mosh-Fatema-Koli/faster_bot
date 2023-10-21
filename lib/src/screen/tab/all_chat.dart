import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/chat/chat_detalis.dart';
import 'package:wow_chat_app/src/screen/tab/controller/unread_controller.dart';
import 'package:wow_chat_app/src/screen/tab/model/chat_model.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/hex_color.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../service/controller/audio_sound.dart';
import '../../service/helper/Prefs_helper.dart';
import '../../service/helper/socket_helper.dart';
import 'controller/all_controller.dart';

class AllChatPage extends StatefulWidget {
  AllChatPage({super.key});

  @override
  State<AllChatPage> createState() => _AllChatPageState();
}

class _AllChatPageState extends State<AllChatPage> {
  final _controller = Get.put(AllChatController());


  @override
  void initState() {
    _controller.fastLoad(true);
    _controller.scrollController=ScrollController();
    _controller.scrollController.addListener(() {
      if (_controller.scrollController.position.pixels ==
          _controller.scrollController.position.maxScrollExtent) {
        _controller.loadMore();
      }
    });
   _controller.getTenantId();
    super.initState();
  }


  @override
  void dispose() {
    _controller.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Check Back System");
    return Scaffold(
      body: Obx(
        () => _controller.isFirstLoadRunning.value
            ? const Center(
                child: CircularProgressIndicator(color: BrandColors.colorButton,),
              )
            :_controller.allChatList.isEmpty? Center(child: KText(text: "No Chat Available",),) :ListView.separated(
                itemCount: _controller.allChatList.value.length + 1,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: _controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index < _controller.allChatList.length) {
                    var data = _controller.allChatList.value[index];
                    return ListTile(
                      onTap: (() {
                        //    Get.to(ChatDtlsPage(listElement: data,));
                        Get.toNamed(chatDetailsScreen, arguments: data,);
                      }),
                      leading:CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        backgroundImage: NetworkImage(
                            "${AppConstants.socketBaseUrl}/images/${data.telegramUserId!.photo??""}"),
                      ),
                      title: KText(
                          text:
                              "${data.telegramUserId!.firstName} ${data.telegramUserId!.lastName??""}",
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color:data.botReadAt==null?Colors.black:Colors.black.withOpacity(0.5),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if( data.label != null && data.label!.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 2.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                          color: BrandColors.colorButton,
                                          width: 0.5,
                                          style: BorderStyle.solid)),
                                  child: KText(
                                    text: data.label,
                                    fontSize: 10.sp,
                                  ),
                                ),

                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            children: [
                              data.lastMessage == "photo"
                                  ?  Icon(
                                      Icons.image,
                                      size: 15.sp,
                                    )
                                  : data.lastMessageBy == "Bot"
                                      ? KText(
                                          text: "You : ",
                                color:data.botReadAt==null?Colors.black:Colors.black.withOpacity(0.5),
                                          fontSize: 13.sp,
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
                                              ? "You sent a photo"
                                              : "Photo",
                                    color:data.botReadAt==null?Colors.black:Colors.black.withOpacity(0.5),
                                          fontSize: 13.sp,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : KText(
                                          text: data.lastMessage,
                                          color:data.botReadAt==null?Colors.black:Colors.black.withOpacity(0.5),
                                          fontSize: 13.sp,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                            ],
                          ),
                        ],
                      ),
                      trailing:data.lastMessageAt==null?SizedBox(): KText(
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
