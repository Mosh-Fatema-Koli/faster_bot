
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/api/api_checker.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/api/api_service.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

import '../../../service/helper/Prefs_helper.dart';



class RegisterationController extends GetxController{

  final nameController = TextEditingController().obs;
  final user_nameController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final botfatherController = TextEditingController().obs;

  RxBool loading = false.obs ;
  var deviceToken = "".obs;
  var sessionToken = "".obs;
  var userIdToken = "".obs;


  Future<void> profileAdd() async {

    // String device = await GetStorage().read(AppConstants.deviceId)??"";
    // String session=  await GetStorage().read(AppConstants.sessionId)??"";
    // String user_id = await GetStorage().read(AppConstants.userId)??"";
    String device = await PrefsHelper.getString(AppConstants.deviceId);
    String session = await PrefsHelper.getString(AppConstants.sessionId);
    String user_id = await PrefsHelper.getString(AppConstants.userId);


    deviceToken.value = device;
    sessionToken.value = session;
    userIdToken.value = user_id;

    print(" Device Id: ${device}");
    print(" session Id: ${session}");
    print(" user Id: ${user_id}");

    loading(true);


    Map<String, dynamic> body = {
      "user_id": userIdToken.value,
      "phone": phoneController.value.text,
      "bot_name":nameController.value.text,
      "bot_username": user_nameController.value.text,
      "botfather_token": botfatherController.value.text
    };

    Response response = await ApiClient.postData(ApiConstant.tenantApi,json.encode(body),
        headers: {
          'x-device': deviceToken.value,
          'x-user': userIdToken.value,
          'x-session': sessionToken.value,
          'Content-Type': 'application/json'
        });

    var data= response.body;
    if(response.statusCode == 201||response.statusCode == 200){
      phoneController.value.clear();
      nameController.value.clear();
      user_nameController.value.clear();
      botfatherController.value.clear();
      loading.value= false;
       await PrefsHelper.setString(AppConstants.tenantId,response.body['data']['tenant']['_id'].toString());

          if(response.body['data']['tenant']['status']== "Active"){

            Get.offAllNamed(homeScreen);
            Get.snackbar("Successfully Added","Congratulation",backgroundColor: BrandColors.colorButton,colorText: Colors.white);
            loading(false);
          }else{
            Get.offNamed(loginScreen);
            loading(false);
            Get.snackbar("Profile is not active", "Contact with your admin",backgroundColor: BrandColors.colorWhite,colorText: BrandColors.colorButton);
          }
      loading(false);
    }
    else if(response.statusCode == 403){
      Get.snackbar("Profile added Failed", data['message'],backgroundColor: BrandColors.colorButton,colorText: Colors.white);
      loading(false);
    }
    else{
       ApiChecker.checkApi(response);
      Get.snackbar("Profile added Failed", data['message'],backgroundColor: BrandColors.colorButton,colorText: Colors.white);
      loading(false);
    }
  }



}

