

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wow_chat_app/src/screen/auth/controller/login_controller.dart';
import 'package:wow_chat_app/src/screen/widgets/custom_snack_bar.dart';
import 'package:wow_chat_app/src/service/helper/Prefs_helper.dart';
import 'package:wow_chat_app/src/service/route/route.dart';
import 'package:wow_chat_app/src/service/utils/app_constent.dart';

class ApiChecker {
 static final GoogleSignIn _googleSignIn = GoogleSignIn();
 static final FirebaseAuth _auth = FirebaseAuth.instance;
  static void checkApi(Response response, {bool getXSnackBar = false})async{
    if(response.statusCode != 200){
      if(response.statusCode == 401||response.statusCode==403||response.statusCode==404) {
        showCustomSnackBar(response.body['message'], getXSnackBar: getXSnackBar);

      }else {
     showCustomSnackBar(response.statusText!, getXSnackBar: getXSnackBar);
      }

    }


  }
}