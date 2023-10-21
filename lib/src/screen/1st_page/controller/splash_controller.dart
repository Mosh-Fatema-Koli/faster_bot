import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/api/api_checker.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/api/api_service.dart';
import 'package:wow_chat_app/src/service/helper/Prefs_helper.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';


class SplashController extends GetxController{
  var isLoading = false.obs;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  var fcmToken = "".obs;
  // final session = GetStorage().read(AppConstants.sessionId);
  //



  Future<void> getFcmToken() async {
    String? token = await _firebaseMessaging.getToken();
    fcmToken.value = token!;
    debugPrint("=====> Get Token successful : $fcmToken");
  }


  deviceRegister() async {
    isLoading(true);

    Map<String, dynamic> body = {
      "fcm_token": fcmToken.value
    };

   Response response = await  ApiClient.postData(
       ApiConstant.deviceRegister, json.encode(body),
       headers: {'Content-Type': 'application/json'}
   );

   print(response.body);
    var data= response.body;

    if(response.statusCode == 200 || response.statusCode == 201){

      debugPrint("--------------------check-------------------");
      debugPrint(data["data"]["device"]);

      debugPrint("--------------------check-------------------");

      await PrefsHelper.setString(AppConstants.deviceId, data["data"]["device"]);
      // await GetStorage().write (AppConstants.deviceId, data["data"]["device"]);
      // await GetStorage().read(AppConstants.deviceId);
      //
      // print(GetStorage().read(AppConstants.deviceId).toString());
      isLoading(false);
      Get.toNamed(loginScreen);

    }
    else{
      isLoading(false);
      ApiChecker.checkApi(response);
    //  Get.snackbar("Your request has been sent ", "Please wait",backgroundColor: Colors.white,colorText: Colors.black);

    }




  }



 tokenCheck() async {
   isLoading(true);

      // var device = await GetStorage().read(AppConstants.deviceId);
      // var session=  await GetStorage().read(AppConstants.sessionId);
      // var user_id = await GetStorage().read(AppConstants.userId);

      var device = await PrefsHelper.getString(AppConstants.deviceId);
      var session=   await PrefsHelper.getString(AppConstants.sessionId);
      var user_id =  await PrefsHelper.getString(AppConstants.userId);
      var tenant_id =  await PrefsHelper.getString(AppConstants.tenantId);
      var active_status =  await PrefsHelper.getBool(AppConstants.isActive);

   print(" Device Id: ${device}");
   print(" session Id: ${session}");
   print(" user Id: ${user_id}");

   try{

     if(device.isEmpty && session.isEmpty && user_id.isEmpty){

       Get.toNamed(introScreen);

     }else if(device.isNotEmpty && session.isEmpty &&user_id.isEmpty ){
        Get.toNamed(loginScreen);

     }else if(device.isNotEmpty && session.isNotEmpty && user_id.isNotEmpty ){

        if(tenant_id.isEmpty && active_status == false){
          Get.toNamed(signupScreen);
        }
       else if(active_status == true && tenant_id.isNotEmpty ){
         Get.offAllNamed(homeScreen);
       }else{
         Get.offAllNamed(homeScreen);
         Get.snackbar("Profile is not active", "Contact with your admin",backgroundColor: BrandColors.colorWhite,colorText: BrandColors.colorButton);
       }

     }
     else{
       isLoading(false);

     }



   isLoading(false);

 } catch (error) {
 debugPrint("Error: $error");
 isLoading(false);
 }



  }




}