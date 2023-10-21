
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:wow_chat_app/src/screen/auth/controller/login_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/button.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/service/route/route.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

 final AuthController _googleController = Get.put(AuthController());

  TextEditingController _controller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: BrandColors.colorButton,


      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

           Lottie.asset("assets/images/login.json",height: 480),
            SizedBox(
              height: 10,
            ),

            Padding(
              padding: const EdgeInsets.all(20).r,
              child: KText(text: "Please enter your Google Account ",color: BrandColors.backgroundColor,textAlign: TextAlign.center,fontSize: 12.sp,),
            ),



            GlobalButtons.buttonWidget(
                text: "Login with Google",color: BrandColors.backgroundColor,
                press: (){
                    _googleController.signIn();
                }
            ),
            SizedBox(height: 15.sp,),
        Obx(() => _googleController.isLoading.value
            ? Center(child: const SizedBox(
          child: Center(
              child: CircularProgressIndicator(
                color: BrandColors.backgroundColor,
              )
          ),
          height: 15.0,
          width: 15.0,
        )):Container())



          ],
        ),
      ),



    );
  }
}
