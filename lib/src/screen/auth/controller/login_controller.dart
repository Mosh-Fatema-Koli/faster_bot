import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/api/api_checker.dart';
import 'package:wow_chat_app/src/service/api/api_client.dart';
import 'package:wow_chat_app/src/service/api/api_service.dart';
import 'package:wow_chat_app/src/service/helper/Prefs_helper.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:http/http.dart' as http;
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

class AuthController extends GetxController {
 // final ProfileController _profileController = Get.put(ProfileController());

  var isLoading = false.obs;
  var deviceToken = "".obs;
  var sessionToken = "".obs;
  var userIdToken = "".obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn() async {
    isLoading(true);

    var device = await PrefsHelper.getString(AppConstants.deviceId);

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

        Map<String, dynamic> body = {

          // "uid": "123456",
          // "email":"dev.it.innova@gmail.com",
          // "name":"Akash Innova"
         "uid": userCredential.user!.uid,
         "email": userCredential.user!.email,
         "name": userCredential.user!.displayName
        };

        Response response = await ApiClient.postData(
            ApiConstant.googleApi, json.encode(body), headers: {
          'x-device': device.toString(),
          'Content-Type': 'application/json'
        });

        if (response.statusCode == 200) {
          await PrefsHelper.setString(AppConstants.sessionId, response.body['data']['session']);
          await PrefsHelper.setString(AppConstants.userId, response.body['data']['user']);

          var appId=  await PrefsHelper.getString(AppConstants.tenantId);

          if(response.body['data']['tenant'] == null ){

            Get.offNamed(signupScreen);

          }else if(response.body['data']['tenant']['status']== "Active" ){
            Get.offAllNamed(homeScreen);
            await PrefsHelper.setString(AppConstants.tenantId,response.body['data']['tenant']['_id'].toString());
            await PrefsHelper.setBool(AppConstants.isActive, true);
            Get.snackbar("Login Successful", "Congratulation",backgroundColor: BrandColors.colorButton,colorText: Colors.white);

          }
          else{
            Get.offNamed(loginScreen);
            Get.snackbar("Profile is not active", "Contact with your admin",backgroundColor: BrandColors.colorWhite,colorText: BrandColors.colorButton);
          }
          //  _profileController.fatchUser();

        } else {
          ApiChecker.checkApi(response);
        }
      }
      isLoading(false);
    } catch (error) {
      debugPrint("Error during Google Sign-In: $error");
      isLoading(false);
    }
  }


  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Map<String, dynamic> body = {};
    Response response = await ApiClient.postData(ApiConstant.logoutApi,json.encode(body));
    if (response.statusCode == 200 || response.statusCode == 201) {
        await PrefsHelper.removeKey(AppConstants.userId);
        await PrefsHelper.removeKey(AppConstants.sessionId);
          await Get.offNamed(loginScreen);
    }else{
      ApiChecker.checkApi(response);
    }

  }


}
