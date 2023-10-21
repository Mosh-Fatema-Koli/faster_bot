import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/default_reply/controller/default_replay_controller.dart';
import 'package:wow_chat_app/src/screen/profile/controller/tanent_user_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';

class WelcomePage extends StatelessWidget {
   WelcomePage({super.key});

   final DefaultReplayController _controller = Get.put(DefaultReplayController());
   final TanentUserController controller = Get.put(TanentUserController());

   @override
   Widget build(BuildContext context) {
     _controller.textWelcomeController.text = controller.tuser?.data?.tenant?.welcomeMessage ?? "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColors.colorButton,
        title: KText(
          text: "Welcome Massage",
          color: BrandColors.backgroundColor,
          fontSize: 14.sp,),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(text: "Send welcome message", fontSize: 18.sp,),
                      SizedBox(
                        height: 5,
                      ),
                      KText(
                        text: "Greet user when they message you the first time.",
                        fontSize: 10.sp,),
                    ],
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: Get.width.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      KText(text: "Welcoming message", fontSize: 18.sp,),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Obx(() => controller.isLoading.value? KText(text: ""):KText(
                                text: controller.tuser?.data?.tenant?.welcomeMessage ?? "Set Your welcome message",
                                fontSize: 10.sp,
                              ))
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(onPressed: () {
                                Get.defaultDialog(
                                  title: "Add Welcoming Message",
                                  //radius: 20,
                                  titleStyle: TextStyle(fontSize: 14.sp),
                                  barrierDismissible: false,
                                  content: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [

                                        TextField(

                                          controller: _controller.textWelcomeController,

                                        )


                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: BrandColors
                                              .colorButton,
                                          elevation: 0.0,
                                          shadowColor: pinkColor,
                                          foregroundColor: Colors.white),
                                      onPressed: () {
                                        _controller.setWelcome();
                                      },
                                      child: Text('Add',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
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
                                      child: Text('Cancel',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),

                                  ],);
                              }, icon: Icon(Icons.edit)))
                        ],
                      ),
                    ],
                  ),

                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}
