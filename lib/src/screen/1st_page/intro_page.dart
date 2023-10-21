
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/1st_page/component/intro_view.dart';
import 'package:wow_chat_app/src/screen/1st_page/controller/splash_controller.dart';
import 'package:wow_chat_app/src/screen/1st_page/model/intro_model.dart';
import 'package:wow_chat_app/src/screen/auth/login.dart';
import 'package:wow_chat_app/src/screen/widgets/button.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/route/route.dart';


class IntroductionScreen extends StatelessWidget {
  IntroductionScreen({Key? key}) : super(key: key);

  PageController pageController = PageController(initialPage: 0);
  List<IntroModel> introPageList = ([
    IntroModel(
      "Email Verification",
      "",
      "assets/images/intro1.jpg",
    ),
    IntroModel(
      "Find Friend Contact",
      "",
      "assets/images/intro2.jpg",
    ),
    IntroModel(
      "Online Messages",
      "",
      "assets/images/intro3.jpg",
    ),
    IntroModel(
      "User Profile",
      "",
      "assets/images/intro4.jpg",
    ),
    IntroModel(
      "Settings",
      "",
      "assets/images/intro5.jpg",
    ),
  ]);

  var currentShowIndex = 0;
  final SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: BrandColors.colorButton,
        ),
      ),
      backgroundColor: BrandColors.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              pageSnapping: true,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (index) {
                currentShowIndex = index;
              },
              scrollDirection: Axis.horizontal,
              children: [
                IntroView(introModel: introPageList[0]),
                IntroView(introModel: introPageList[1]),
                IntroView(introModel: introPageList[2]),
                IntroView(introModel: introPageList[3]),
                IntroView(introModel: introPageList[4]),
              ],
            ),
          ),
          SmoothPageIndicator(
              controller: pageController, // PageController
              count: introPageList.length,
              effect: WormEffect(
                dotColor: Colors.grey,
                activeDotColor: BrandColors.colorButton,
              ),
              onDotClicked: (index) {}),
          Padding(
            padding: const EdgeInsets.only(
              left: 48,
              right: 48,
              bottom: 32,
              top: 32,
            ),
            child:  GlobalButtons.buttonWidget(text: "Start Messaging",color: BrandColors.colorButton,textColor: Colors.white,press: (){
              _splashController.deviceRegister();
            })
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}