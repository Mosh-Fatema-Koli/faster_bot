import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/chat/chat_detalis.dart';
import 'package:wow_chat_app/src/screen/tab/model/chat_model.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/hex_color.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/service/route/route.dart';


class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatdata.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) => Column(
          children: [
            Divider(
              height: 10,
            ),
            ListTile(
              onTap: (() {
              }),
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                //   backgroundImage: AssetImage(chatdata[index].avater),
              ),
              title: KText(text: chatdata[index].name,fontWeight: FontWeight.bold,fontSize: 14.sp,),

              subtitle:Row(
                children: [
                  Icon(Icons.done_all,color: Colors.red,size: 15,),
                  KText(text: chatdata[index].massage,color: BrandColors.greyColor,fontSize: 10.sp,),
                ],
              ),
              trailing: IconButton(onPressed: (){
                Get.toNamed(chatDetailsScreen);
              }, icon: Icon(Icons.message)),
            ),
          ],
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