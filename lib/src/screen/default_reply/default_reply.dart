import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:wow_chat_app/src/screen/default_reply/controller/default_replay_controller.dart';
import 'package:wow_chat_app/src/screen/profile/controller/tanent_user_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/screen/widgets/text_box_field.dart';

class DefaultReply extends StatelessWidget {
  DefaultReply({super.key});

  final DefaultReplayController _controller = Get.put(DefaultReplayController());
  final TanentUserController controller = Get.put(TanentUserController());

  @override
  Widget build(BuildContext context) {

    _controller.textController.text = controller.tuser?.data?.tenant?.defaultReply!??"";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColors.colorButton,
        title: KText(
          text: "Default replay",
          color: BrandColors.backgroundColor,
          fontSize: 14.sp,
        ),
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
                      KText(
                        text: "Send greeting message",
                        fontSize: 18.sp,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      KText(
                        text:
                            "Greet user when they message you the first time.",
                        fontSize: 10.sp,
                      ),
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
                  child: Obx(
                    () => _controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              KText(
                                text: "Greeting message",
                                fontSize: 18.sp,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Obx(() => controller.isLoading.value? KText(text: ""):KText(
                                        text: controller.tuser?.data?.tenant?.defaultReply ?? "Set Your default replay",
                                        fontSize: 10.sp,
                                      ))
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            Get.defaultDialog(
                                              title: "Add Default Reply",
                                              //radius: 20,
                                              titleStyle:
                                                  TextStyle(fontSize: 14.sp),
                                              barrierDismissible: false,
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  children: [
                                                    TextField(
                                                      controller: _controller.textController,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              BrandColors
                                                                  .colorButton,
                                                          elevation: 0.0,
                                                          shadowColor:
                                                              pinkColor,
                                                          foregroundColor:
                                                              Colors.white),
                                                  onPressed: () {
                                                    _controller
                                                        .setDefaultReplay();
                                                  },
                                                  child: Text(
                                                    'Add',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                TextButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          backgroundColor:
                                                              Colors.red,
                                                          elevation: 0.0,
                                                          shadowColor:
                                                              pinkColor,
                                                          foregroundColor:
                                                              Colors.white),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          icon: Icon(Icons.edit)))
                                ],
                              ),
                            ],
                          ),
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
