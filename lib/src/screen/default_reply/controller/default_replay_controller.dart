import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/default_reply/model/default_replay_model.dart';
import 'package:wow_chat_app/src/screen/profile/controller/tanent_user_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/api/api_checker.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/api/api_service.dart';
import 'package:wow_chat_app/src/service/helper/Prefs_helper.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

class DefaultReplayController extends GetxController{

  final TanentUserController controller = Get.put(TanentUserController());

  RxString reply="".obs;
  var isLoading = false.obs;
  TextEditingController textController =TextEditingController();
  TextEditingController textWelcomeController =TextEditingController();

  @override
  void onInit() {
    controller.fatchTanent();
    super.onInit();
  }


  setDefaultReplay() async {
    isLoading(true);
    String tenant_id = await PrefsHelper.getString(AppConstants.tenantId);
    Map<String, dynamic> body ={

      "message": textController.text
    };
    Response response = await ApiClient.postData("${ApiConstant.updateDefaultMassage}$tenant_id/default", json.encode(body),);
    if(response.statusCode == 200 || response.statusCode == 201){
      DefaultReplayModel demoModel= DefaultReplayModel.fromJson(response.body);
      reply.value = demoModel.data!.tenant!.defaultReply! ;
      update();
      Get.back();
      Get.snackbar("DefaultReply Has been added", "Thanks",backgroundColor: BrandColors.colorWhite,colorText: BrandColors.colorButton);
      controller.fatchTanent();
      textController.clear();
      isLoading(false);
    }else{
      ApiChecker.checkApi(response);
      isLoading(false);
    }
  }

  setWelcome() async {
    isLoading(true);
    String tenant_id = await PrefsHelper.getString(AppConstants.tenantId);
    Map<String, dynamic> body ={
      "message": textWelcomeController.text
    };
    Response response = await ApiClient.postData("${ApiConstant.updateDefaultMassage}$tenant_id/welcome", json.encode(body),);
    if(response.statusCode == 200 || response.statusCode == 201){
      DefaultReplayModel demoModel= DefaultReplayModel.fromJson(response.body);
      reply.value = demoModel.data!.tenant!.welcomeMessage! ;
      update();
      Get.back();
      textWelcomeController.clear();
      Get.snackbar("Welcome message Has been added", "Thanks",backgroundColor: BrandColors.colorWhite,colorText: BrandColors.colorButton);
      controller.fatchTanent();


      isLoading(false);
    }else{
      ApiChecker.checkApi(response);
      isLoading(false);
    }
  }




}