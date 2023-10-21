import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:wow_chat_app/src/screen/tab/controller/all_controller.dart';
import 'package:wow_chat_app/src/screen/tab/controller/unread_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/api/api_checker.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/api/api_service.dart';
import 'package:wow_chat_app/src/service/helper/socket_helper.dart';
import 'package:wow_chat_app/src/service/route/route.dart';

import '../tab/controller/un_answered_controller.dart';

class LabelController extends GetxController {
  final _allcontroller = Get.put(AllChatController());
  final _unAnscontroller = Get.put(UnAnsweredController());
  final _unReadcontroller = Get.put(UnreadController());

  TextEditingController labelTextController = TextEditingController();

  var isLoading = false.obs;

 Future<dynamic> setLabel(String id) async {
    isLoading(true);
    Map<String, dynamic> body = {"label": labelTextController.text};
    Response response = await ApiClient.postData(
        ApiConstant.labelAddApi + id, json.encode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
      for (int i = 0; i < _allcontroller.allChatList.length; i++) {
        if (response.body['data']['thread']['_id'] ==
            _allcontroller.allChatList[i].id) {
          _allcontroller.allChatList[i].label =
              response.body['data']['thread']['label'];
          _allcontroller.allChatList.refresh();
          break;
        }
      }
      for (int i = 0; i < _unAnscontroller.unAnsweredList.length; i++) {
        if (response.body['data']['thread']['_id'] ==
            _unAnscontroller.unAnsweredList[i].id) {
          _unAnscontroller.unAnsweredList[i].status =
              response.body['data']['thread']['label'];
          _unAnscontroller.unAnsweredList.refresh();

          break;
        }
      }
      for (int i = 0; i < _unReadcontroller.unreadList.length; i++) {
        if (response.body['data']['thread']['_id'] ==
            _unReadcontroller.unreadList[i].id) {
          _unReadcontroller.unreadList[i].status =
              response.body['data']['thread']['label'];
          _unReadcontroller.unreadList.refresh();
          break;
        }
      }
      Get.back();
      Get.snackbar("Label Has been added", "Thanks",
          backgroundColor: BrandColors.colorWhite,
          colorText: BrandColors.colorButton);
      isLoading(false);
      return  response.body['data']['thread']['label'];
    } else {
      ApiChecker.checkApi(response);
      isLoading(false);
    return 1;
    }
  }
}
