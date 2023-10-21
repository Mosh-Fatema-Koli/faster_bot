
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/profile/model/tanent_user_model.dart';
import 'package:wow_chat_app/src/service/api/api_checker.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/api/api_service.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

import '../../../service/helper/Prefs_helper.dart';

class TanentUserController extends GetxController {
  var isLoading=false.obs;
  TenentUserModel? tuser;

  @override
  void onInit() {
    fatchTanent();
    super.onInit();
  }



  fatchTanent() async {
    isLoading(true);
    var device = await PrefsHelper.getString(AppConstants.deviceId);
    var session=   await PrefsHelper.getString(AppConstants.sessionId);
    var user_id =  await PrefsHelper.getString(AppConstants.userId);
    var tanent_id =  await PrefsHelper.getString(AppConstants.tenantId);


    Response response =
    await ApiClient.getData(ApiConstant.tanenDetialsApi+tanent_id, headers: {
      'x-device': device,
      'x-user': user_id,
      'x-session': session
    });

    if (response.statusCode == 200) {
     var user = TenentUserModel.fromJson(response.body);
        tuser=user;
      isLoading(false);
    } else {
      print("Failed");
      ApiChecker.checkApi(response);
    }

  }


}
