import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/service/helper/Prefs_helper.dart';
import 'package:wow_chat_app/src/service/helper/socket_helper.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

import '../../../service/api/api_checker.dart';
import '../../../service/api/api_client.dart';
import '../../../service/api/api_service.dart';
import '../../../service/controller/audio_sound.dart';
import '../model/unread_chat_model.dart';
class AllChatController extends GetxController{
  RxList<ListElement> allChatList=<ListElement>[].obs;
  late ScrollController scrollController;
  final audioController = Get.put(AudioPlayerController());
  int page = 1;
  var isFirstLoadRunning = false.obs;
  var isLoadMoreRunning = false.obs;
  var tenantId="";
  var totalPage=(-1);
  var currentPage=(-1);


  getTenantId()async{
    tenantId= await PrefsHelper.getString(AppConstants.tenantId);
    await disposeListen();
    await receivedListen();
  }
  receivedListen()async{
    print('======> Received data on Screen all chat listen');

    SocketApi.socket.on('APP::CHAT::THREAD::LIST::$tenantId',(data)
    {
      print('Received data on Screen All Chat: $data');
      fastLoad(false);
      audioController.playAudio();
    });
  }

  disposeListen()async{
    SocketApi.socket.off('APP::CHAT::THREAD::LIST::$tenantId');
    SocketApi.socket.dispose();
    SocketApi.socket.disconnect().connect();
    print('======> Received data on Screen all chat listen Dispose');
  }

  fastLoad(bool isLoading)async {
    if(isLoading){
      isFirstLoadRunning(true);
    }
    page=1;

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
    await ApiClient.getData("${ApiConstant.allChatThreadListApi}$tenantId/$page/30",headers: headers);
    if (response.statusCode == 200) {
      currentPage=response.body['data']['current_page'];
      totalPage=response.body['data']['total_pages'];
      var demoList = List<ListElement>.from(response.body['data']['list'].map((x) => ListElement.fromJson(x)));
      allChatList.value=demoList;
      print(allChatList.length);
      allChatList.refresh();
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    isFirstLoadRunning(false);
  }

  loadMore() async {
    print("load more");
    if (isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false && totalPage != currentPage) {
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
      await ApiClient.getData(
          "${ApiConstant.allChatThreadListApi}$tenantId/$page/30",
          headers: headers);
      currentPage = response.body['data']['current_page'];
      totalPage = response.body['data']['total_pages'];
      if (response.statusCode == 200) {
        var demoList = List<ListElement>.from(
            response.body['data']['list'].map((x) => ListElement.fromJson(x)));
        allChatList.addAll(demoList);

        allChatList.refresh();
      } else {
        ApiChecker.checkApi(response);
      }
      isLoadMoreRunning(false);
    }
  }

  @override
  void dispose() {
    audioController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}