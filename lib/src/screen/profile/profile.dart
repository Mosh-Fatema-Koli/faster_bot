import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/profile/controller/tanent_user_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/service/route/route.dart';

class ProfiePage extends StatefulWidget {
  ProfiePage({super.key});

  @override
  State<ProfiePage> createState() => _ProfiePageState();
}

class _ProfiePageState extends State<ProfiePage> {

  final TanentUserController controller = Get.put(TanentUserController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: BrandColors.colorButton,
        ),
      ),

      body: Column(
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
                      height: 50.h,
                      width: Get.width/3,
                      child: Stack(
                        children: [


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

            Obx(() => controller.isLoading.value ? Center(child: CircularProgressIndicator(color: BrandColors.colorButton,)):Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Card(
                      child: Padding(
                        padding: const EdgeInsets.all(30).r,
                        child: Row(
                          children: [
                            KText(text: "Name : ",fontWeight: FontWeight.bold,),
                            KText(text:  controller.tuser!.data!.tenant!.userId!.name ??"")
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
                            KText(text: "Email : ",fontWeight: FontWeight.bold,),
                            KText(text:  controller.tuser!.data!.tenant!.userId!.email??"")
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
                            KText(text: "Bot Name : ",fontWeight: FontWeight.bold,),
                            KText(text:  controller.tuser!.data!.tenant!.botName??"")
                          ],
                        ),
                      )
                  ),
                  Card(
                      child: Padding(
                        padding: EdgeInsets.all(30).r,
                        child: Row(
                          children: [
                            KText(text: "Bot User Name: ",fontWeight: FontWeight.bold,),
                            KText(text:  controller.tuser!.data!.tenant!.botUsername??"")
                          ],
                        ),
                      )
                  ),
                  Card(
                      child: Padding(
                        padding: EdgeInsets.all(30).r,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(text: "Bot Father Token: ",fontWeight: FontWeight.bold,),
                            Expanded(child: KText(text:  controller.tuser!.data!.tenant!.botfatherToken??""))
                          ],
                        ),
                      )
                  ),




                ],
              ),
            )),




          ],
        ),
      );


  }
}
