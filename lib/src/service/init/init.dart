import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/1st_page/controller/splash_controller.dart';
import 'package:wow_chat_app/src/screen/auth/controller/login_controller.dart';


Future init()async{

  Get.lazyPut(() => SplashController());
  Get.lazyPut(() => AuthController());




}