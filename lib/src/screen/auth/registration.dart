
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/auth/controller/registration_controller.dart';
import 'package:wow_chat_app/src/screen/auth/login.dart';
import 'package:wow_chat_app/src/screen/widgets/button.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/screen/widgets/text_box_field.dart';
import 'package:wow_chat_app/src/screen/widgets/validation.dart';
import 'package:wow_chat_app/src/service/route/route.dart';

class RegistrationPage extends StatelessWidget {
 RegistrationPage({super.key});

 final RegisterationController _registerationController = Get.put(RegisterationController());
 final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: BrandColors.colorButton,
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15).r,
          child: Form(
        key: formKey ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: 80.h,
                ),
                Center(
                  child: Container(
                    height: 150.h,
                    width: Get.width/3,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:AssetImage("assets/images/profile.png"),

                          radius: 70.r,
                        ),
                        // Positioned(
                        //     right: 20,
                        //     bottom: 30,
                        //     child: CircleAvatar(
                        //       backgroundColor: BrandColors.colorButton,
                        //       child: IconButton(onPressed: (){}, icon: Icon(Icons.photo_camera,color: Colors.white,)),
                        //     ))

                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:5),
                  child: KText(text: "Bot Name:"),
                ),
                CustomTextField(
                  hintText: "Enter your name",
                  controller: _registerationController.nameController.value,
                  validator: Validators.nameValidator,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:5),
                  child: KText(text: "Bot User Name:"),
                ),
                CustomTextField(
                  hintText: "Enter your bot user name",
                  controller: _registerationController.user_nameController.value,
                  validator: Validators.nameValidator,
                ),
                SizedBox(
                  height: 10,
                ),


                Padding(
                  padding: const EdgeInsets.symmetric(vertical:5),
                  child: KText(text: "Phone Number:"),

                ),

                CustomTextField(
                  hintText: "Enter your phone number",
                  maxLength: 11,
                  keybord: TextInputType.number,
                  controller: _registerationController.phoneController.value,
                  validator: Validators.phoneValidator,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:5),
                  child: KText(text: "Bot Father token"),
                ),
                CustomTextField(
                  maxNumber:3,
                  hintText: "Inter your bot father token",
                  controller: _registerationController.botfatherController.value,
                  validator: Validators.nameValidator,
                ),
                SizedBox(
                  height: 30.h,
                ),
                GlobalButtons.buttonWidget(
                    text: "Submit",color: BrandColors.colorButton,textColor: Colors.white,
                    press: (){

                      if (formKey.currentState!.validate()) {
                        _registerationController.profileAdd();
                      }

                    }
                ),
                SizedBox(height: 15.sp,),
                Obx(() => _registerationController.loading.value
                    ? Center(child: const SizedBox(
                  child: Center(
                      child: CircularProgressIndicator(
                        color: BrandColors.colorButton,
                      )
                  ),
                  height: 15.0,
                  width: 15.0,
                )):Container())



              ],
            ),
          ),
        ),
      ),

    );
  }
}
