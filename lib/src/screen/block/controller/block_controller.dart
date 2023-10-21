import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/block/model/block_model.dart';
import 'package:wow_chat_app/src/screen/chat/controller/chat_controller.dart';
import 'package:wow_chat_app/src/screen/tab/controller/all_controller.dart';
import 'package:wow_chat_app/src/screen/tab/controller/un_answered_controller.dart';
import 'package:wow_chat_app/src/screen/tab/controller/unread_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/api/api_checker.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/api/api_service.dart';
import 'package:wow_chat_app/src/service/helper/Prefs_helper.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

class BlockController extends GetxController {
  final ChatDController _controller = Get.put(ChatDController());

  final _allcontroller = Get.put(AllChatController());
  final _unAnscontroller = Get.put(UnAnsweredController());
  final _unReadcontroller = Get.put(UnreadController());

  RxList<ListElement> allBlockList=<ListElement>[].obs;


  var isLoading = false.obs;
  var tenantId="";

  void onInit() {

    getBlockList();
    super.onInit();

  }

 Future<String> addBlock(String id, String name,String lastName) async {

    isLoading(true);
    Map<String, dynamic> body = {
    };
    Response response = await ApiClient.getData(ApiConstant.addBlocklistApi+id,);
    if (response.statusCode == 200 || response.statusCode == 201) {
      update();

    for(int i=0; i<_allcontroller.allChatList.length; i++){

      if(response.body['data']['thread']['_id'] == _allcontroller.allChatList[i].id){
        _allcontroller.allChatList[i].status ="Blocked";
        _allcontroller.allChatList.refresh();
        break;
      }
    }
      for(int i=0; i<_unAnscontroller.unAnsweredList.length; i++){
        if(response.body['data']['thread']['_id'] == _unAnscontroller.unAnsweredList[i].id){
          _unAnscontroller.unAnsweredList[i].status ="Blocked";
          _unAnscontroller.unAnsweredList.refresh();

          break;
        }

      }
      for(int i=0; i<_unReadcontroller.unreadList.length; i++){

        if(response.body['data']['thread']['_id'] == _unReadcontroller.unreadList[i].id){
          _unReadcontroller.unreadList[i].status ="Blocked";
          _unReadcontroller.unreadList.refresh();
          break;
        }

      }

      print("${response.body['data']['thread']['status']}*********************************");

      Get.snackbar("${name} ${lastName} has been blocked ", "",backgroundColor: BrandColors.colorButton,colorText: Colors.white);
      isLoading(false);

      return response.body['data']['thread']['status'];

    } else {
      ApiChecker.checkApi(response);
      isLoading(false);
      return "Error";
    }
  }


 Future<dynamic> addUnBlock(String id, String name,String lastName) async {
    isLoading(true);
    Map<String, dynamic> body = {
    };
    Response response = await ApiClient.getData(ApiConstant.addUnBlocklistApi+id,);
    if (response.statusCode == 200 || response.statusCode == 201) {
      update();
      for(int i=0; i<_allcontroller.allChatList.length; i++){

        if(response.body['data']['thread']['_id'] == _allcontroller.allChatList[i].id){
          _allcontroller.allChatList[i].status ="Active";
          _allcontroller.allChatList.refresh();
          update();
        }
      }
      for(int i=0; i<_unAnscontroller.unAnsweredList.length; i++){

        if(response.body['data']['thread']['_id'] == _unAnscontroller.unAnsweredList[i].id){
          _unAnscontroller.unAnsweredList[i].status ="Active";
          _unAnscontroller.unAnsweredList.refresh();
          break;
        }

      }
      for(int i=0; i<_unReadcontroller.unreadList.length; i++){

        if(response.body['data']['thread']['_id'] == _unReadcontroller.unreadList[i].id){
          _unReadcontroller.unreadList[i].status ="Active";
          _unReadcontroller.unreadList.refresh();
          break;
        }

      }
      Get.snackbar("${name} ${lastName} has been unblocked ", "",backgroundColor: BrandColors.colorButton,colorText: Colors.white);
      isLoading(false);
      _controller.chatList.refresh();
      return "Active";
    } else {
      ApiChecker.checkApi(response);
      isLoading(false);
      return 1;
    }
  }

  getBlockList() async {
    String tenantId = await PrefsHelper.getString(AppConstants.tenantId);
    isLoading(true);
    Response response = await ApiClient.getData(ApiConstant.getBlocklistApi+tenantId);

    if (response.statusCode == 200 || response.statusCode == 201) {

        var demoList = List<ListElement>.from(response.body['data']['list'].map((x) => ListElement.fromJson(x)));
        allBlockList.value=demoList;

      isLoading(false);
    } else {
     ApiChecker.checkApi(response);
      isLoading(false);
    }
  }


}