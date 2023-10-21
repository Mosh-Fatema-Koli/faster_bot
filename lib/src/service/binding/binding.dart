import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/1st_page/controller/splash_controller.dart';
import 'package:wow_chat_app/src/screen/auth/controller/login_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    // Bindings from core
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);

  }
}