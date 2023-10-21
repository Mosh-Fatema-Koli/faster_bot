import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/1st_page/intro_page.dart';
import 'package:wow_chat_app/src/screen/1st_page/splash.dart';
import 'package:wow_chat_app/src/screen/auth/login.dart';
import 'package:wow_chat_app/src/screen/auth/registration.dart';
import 'package:wow_chat_app/src/screen/block/block.dart';
import 'package:wow_chat_app/src/screen/broadcasting/perticipent_page.dart';
import 'package:wow_chat_app/src/screen/chat/chat_detalis.dart';
import 'package:wow_chat_app/src/screen/chat/image-picked.dart';
import 'package:wow_chat_app/src/screen/default_reply/default_reply.dart';
import 'package:wow_chat_app/src/screen/home/home.dart';
import 'package:wow_chat_app/src/screen/profile/profile.dart';
import 'package:wow_chat_app/src/screen/profile/user_profile.dart';
import 'package:wow_chat_app/src/screen/search/search.dart';
import 'package:wow_chat_app/src/screen/welcome_massage/welcome_message.dart';



const String splashScreen = "/splash-screen";
const String introScreen = "/intro_screen";
const String loginScreen = "/login_screen";
const String signupScreen = "/registration_screen";
const String forgetPassScreen = "/forget_password_screen";
const String changePassScreen = "/change_password_screen";
const String homeScreen = "/home_screen";
const String searchScreen = "/search_screen";
const String profileScreen = "/profile_screen";
const String profileEditScreen = "/edit_profile_screen";
const String chatDetailsScreen = "/chat_details_screen";
const String imagesent = "/imagesent";

const String defaultScreen = "/default_screen";
const String welcomeScreen = "/welcome_message_screen";
const String participantScreen = "/broadCasting_screen/participant_screen";
const String tanentProfile = "/Tanent_profile";

const String blockScreen = "/block_screen";
const String userprofileScreen = "/user_profile_screen";



List<GetPage> getPages = [

  GetPage(name: splashScreen, page: (() => SplashScreen()),),
  GetPage(name: introScreen, page: (() => IntroductionScreen()), ),
  GetPage(name: loginScreen, page: () => LoginPage(), transition: Transition.fade,  ),
  GetPage(name: signupScreen, page: (() => RegistrationPage()), transition: Transition.fade,),
  GetPage(name: homeScreen, page: () => HomePage(),),
  GetPage(name: searchScreen, page: () => SearchPage(),transition: Transition.downToUp,transitionDuration: Duration(milliseconds: 2)),
  GetPage(name: profileScreen, page: () => ProfiePage()),

  GetPage(name: chatDetailsScreen, page: () => ChatDtlsPage()),
  GetPage(name: imagesent, page: () =>  ImagePage()),

  GetPage(name: welcomeScreen, page: () => WelcomePage()),
  GetPage(name: defaultScreen, page: () => DefaultReply()),
  GetPage(name: participantScreen, page: () => RecipientPage()),
  GetPage(name: blockScreen, page: () => BlockPage()),
  GetPage(name: tanentProfile, page: () => TanentProfile()),



];