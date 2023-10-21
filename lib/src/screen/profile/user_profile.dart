
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wow_chat_app/src/screen/profile/controller/tanent_user_controller.dart';
import 'package:wow_chat_app/src/screen/tab/model/unread_chat_model.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/screen/widgets/text_box_field.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';



class TanentProfile extends StatefulWidget {
  const TanentProfile({super.key});

  @override
  State<TanentProfile> createState() => _TanentProfileState();
}

class _TanentProfileState extends State<TanentProfile> {

  ListElement userData = Get.arguments;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: BrandColors.colorButton,
        ),
      ),

      body:
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: BrandColors.colorButton,
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      Get.back();
                    }, icon: Icon(Icons.arrow_back,color: BrandColors.colorBackground,)),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Center(
                  child: Container(
                    height: 150.h,
                    width: Get.width/3,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.blueGrey,
                          backgroundImage: NetworkImage(
                              "${AppConstants.socketBaseUrl}/images/${userData.telegramUserId!.photo}"),
                        ),


                      ],
                    ),
                  ),
                ),
                // KText(text: _controller.user!.data!.user!.name.toString()??"",fontSize: 18.sp,color: BrandColors.backgroundColor,),
                SizedBox(
                  height: 10.h,
                ),

              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Card(
                    child: Padding(
                      padding: const EdgeInsets.all(30).r,
                      child: Row(
                        children: [
                          KText(text: "Name : ",fontWeight: FontWeight.bold,),
                          KText(text: "${userData.telegramUserId!.firstName} ${userData.telegramUserId!.lastName??""}" ??"")
                        ],
                      ),
                    )
                ),
                SizedBox(
                  height: 5.h,
                ),

                Card(
                    child: Padding(
                      padding: EdgeInsets.all(30).r,
                      child: Row(
                        children: [
                          KText(text: "Status : ",fontWeight: FontWeight.bold,),
                          KText(text: "${userData.status} "??"")
                        ],
                      ),
                    )
                ),
                SizedBox(
                  height: 5.h,
                ),
                Card(
                    child: Padding(
                      padding: EdgeInsets.all(30).r,
                      child: Row(
                        children: [
                          KText(text: "Label : ",fontWeight: FontWeight.bold,),
                          KText(text: userData.label!=null ? userData.label: "No label added")
                        ],
                      ),
                    )
                ),
                SizedBox(
                  height: 5.h,
                ),
                Card(
                    child: Padding(
                      padding: EdgeInsets.all(30).r,
                      child: Row(
                        children: [
                          KText(text: "Created Bot : ",fontWeight: FontWeight.bold,),

                          KText(text: userData.updatedAt.toString().substring(0,10),)
                        ],
                      ),
                    )
                ),
                SizedBox(
                  height: 5.h,
                ),




              ],
            ),
          )




        ],
      ),
    );
  }
}

