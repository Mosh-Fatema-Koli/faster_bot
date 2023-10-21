import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/search/controller/all_user_controller.dart';
import 'package:wow_chat_app/src/screen/tab/customs.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/screen/widgets/text_box_field.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchPage extends StatelessWidget {
   SearchPage({super.key});
  final _controller = Get.put(AllUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColors.backgroundColor,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(80),

        child: AppBar(
          toolbarHeight: 75,
          titleSpacing: 5,
          automaticallyImplyLeading: false,
          backgroundColor: BrandColors.colorButton,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              CustomTextField(

                  hintText: "Search",
                  suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.search,color: BrandColors.greyColor,size: 30,)),
                  prefixIcon: IconButton(
                    icon:Icon(
                      Icons.arrow_back,color: BrandColors.colorDark,
                    ),
                    onPressed: (){
                      Get.back();
                    },
                  ),

              ),
            ],
          ),
          elevation: 1,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [

          Row(
            children: [
              KText(text: "All Users",fontSize: 14.sp,fontWeight: FontWeight.w600,color: BrandColors.greyColor,)

            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
                child: Obx(
                      () => _controller.isFirstLoadRunning.value
                      ? const Center(
                    child: CircularProgressIndicator(color: BrandColors.colorButton,),
                  )
                      : ListView.separated(
                    itemCount: _controller.allChatList.value.length+1,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < _controller.allChatList.length) {
                        var data = _controller.allChatList.value[index];
                        return ListTile(
                          contentPadding: EdgeInsets.all(8),
                          onTap: (() {
                            //    Get.to(ChatDtlsPage(listElement: data,));
                           // Get.toNamed(chatDetailsScreen, arguments: data);
                          }),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueGrey,
                            backgroundImage: NetworkImage(
                                "${AppConstants.socketBaseUrl}/images/${data.telegramUserId!.photo}"??""),
                          ),
                          title: KText(
                              text:
                              "${data.telegramUserId!.firstName} ${data.telegramUserId!.lastName}"??"",
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                  child: data.label != null? Row(
                                    children: [
                                      Icon(Icons.arrow_right_rounded,color: BrandColors.colorButton,),
                                      KText(text:data.label,fontSize: 12,),
                                    ],
                                  ):KText(text: "",fontSize: 2,)

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
                          trailing:IconButton(onPressed: (){}, icon: Icon(Icons.message,color: BrandColors.colorButton,))
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
                )
          )

  ],
        ),
      ),
    );
  }
}
