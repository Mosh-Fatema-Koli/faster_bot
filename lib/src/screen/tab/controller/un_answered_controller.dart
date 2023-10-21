import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/service/helper/Prefs_helper.dart';
import 'package:wow_chat_app/src/service/helper/socket_helper.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

import '../../../service/api/api_checker.dart';
import '../../../service/api/api_client.dart';
import '../../../service/api/api_service.dart';
import '../model/unread_chat_model.dart';
class UnAnsweredController extends GetxController{
  RxList<ListElement> unAnsweredList=<ListElement>[].obs;
  late ScrollController  scrollController;
  var isLoading=false.obs;
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var tenantId="";
  var totalPage=(-1);
  var currentPage=(-1);

  fastLoad()async {
    page=1;
    isFirstLoadRunning(true);
    tenantId= await PrefsHelper.getString(AppConstants.tenantId);
     var deviceToken=await PrefsHelper.getString(AppConstants.deviceId);
     var sessionToken=await PrefsHelper.getString(AppConstants.sessionId);
     var userId=await PrefsHelper.getString(AppConstants.userId);
    var headers = {
      'x-device': deviceToken,
      'x-user': userId,
      'x-session': sessionToken
    };
    // var headers = {
    //   'x-device': '651e63e09446654dcf1f0bc7',
    //   'x-user': '651e640e9446654dcf1f0bca',
    //   'x-session': '651e640e9446654dcf1f0bcc'
    // };
    Response response =
    await ApiClient.getData("${ApiConstant.unAnsweredChatThreadListApi}$tenantId/$page/15",headers: headers);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['current_page'];
      totalPage=response.body['data']['total_pages'];
      var demoList = List<ListElement>.from(response.body['data']['list'].map((x) => ListElement.fromJson(x)));
      unAnsweredList.value=demoList;
    } else {
      ApiChecker.checkApi(response);
    }
    isFirstLoadRunning(false);
  }

  loadMore() async {
    print("load more");
    if (isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false&&totalPage != currentPage) {
      isLoadMoreRunning(true);
      page += 1;
      var deviceToken=await PrefsHelper.getString(AppConstants.deviceId);
      var sessionToken=await PrefsHelper.getString(AppConstants.sessionId);
      var userId=await PrefsHelper.getString(AppConstants.userId);
      var headers = {
        'x-device': deviceToken,
        'x-user': userId,
        'x-session': sessionToken
      };
      // var headers = {
      //   'x-device': '651e63e09446654dcf1f0bc7',
      //   'x-user': '651e640e9446654dcf1f0bca',
      //   'x-session': '651e640e9446654dcf1f0bcc'
      // };
      Response response =
      await ApiClient.getData("${ApiConstant.unAnsweredChatThreadListApi}$tenantId/$page/15",headers:headers);
      currentPage=response.body['data']['current_page'];
      totalPage=response.body['data']['total_pages'];
      if (response.statusCode == 200) {
        var demoList = List<ListElement>.from(response.body['data']['list'].map((x) => ListElement.fromJson(x)));
        unAnsweredList.addAll(demoList);
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }}



}