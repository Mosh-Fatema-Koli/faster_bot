
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/1st_page/controller/splash_controller.dart';
import 'package:wow_chat_app/src/screen/1st_page/intro_page.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/route/route.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController slideAnimation;
  late Animation<Offset> offsetAnimation;
  late Animation<Offset> textAnimation;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this,
        lowerBound: 0,
        upperBound: 60,
        animationBehavior: AnimationBehavior.normal,
        duration: const Duration(milliseconds: 700));

    animationController.forward();

    slideAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));

    offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: slideAnimation,
      curve: Curves.fastOutSlowIn,
    ));

    textAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.2, 0.0),
    ).animate(
        CurvedAnimation(parent: slideAnimation, curve: Curves.fastOutSlowIn));

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        slideAnimation.forward();
      }
    });

    Future.delayed(const Duration(seconds: 3), () {

      final SplashController _splashController = Get.put(SplashController());
      _splashController.getFcmToken();
      _splashController.tokenCheck();


    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: BrandColors.colorButton,
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: animationController,
                builder: (_, child) {
                  return SlideTransition(
                    position: offsetAnimation,
                    child: Icon(
                      Icons.chat,
                      color: BrandColors.colorButton,
                      size: animationController.value,
                    ),
                  );
                },
              ),
              SlideTransition(
                position: textAnimation,
                child: const Text(
                  "Faster Bot",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: BrandColors.colorButton,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}