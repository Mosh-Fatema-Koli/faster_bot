import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/auth/controller/login_controller.dart';
import 'package:wow_chat_app/src/screen/tab/all_chat.dart';
import 'package:wow_chat_app/src/screen/tab/controller/all_controller.dart';
import 'package:wow_chat_app/src/screen/tab/controller/unread_controller.dart';
import 'package:wow_chat_app/src/screen/tab/customs.dart';
import 'package:wow_chat_app/src/screen/tab/un_answered.dart';
import 'package:wow_chat_app/src/screen/tab/unread.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/screen/widgets/k_text.dart';
import 'package:wow_chat_app/src/service/helper/socket_helper.dart';
import 'package:wow_chat_app/src/service/route/route.dart';

import '../../service/helper/Prefs_helper.dart';
import '../../service/utils/app_constent.dart';

class HomePage extends StatefulWidget {
 HomePage({super.key});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<Tab> topTabs = [
    const Tab(
      text: "All",
    ),
    const Tab(
      text: "Unread",
    ),
    const Tab(
      text: "UnAnswered",
    ),

  ];
  @override
  void initState() {
    SocketApi.init();
    tabController = TabController(length: 3, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColors.backgroundColor,
      appBar: AppBar(

        automaticallyImplyLeading: false,
        backgroundColor: BrandColors.backgroundColor,

        title: KText(text: "Faster Bot",color: BrandColors.colorButton ,fontWeight: FontWeight.bold,fontSize: 20,),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(welcomeScreen);
            },
            icon: const Icon(Icons.message,color: BrandColors.colorButton,size: 22,),
          ),

          IconButton(
            onPressed: () {
              print("Clicked Search");
              Get.toNamed(searchScreen, );
            },
            icon: const Icon(Icons.search,color: BrandColors.colorButton,size: 25,),
          ),

          PopupMenuButton<String>(
            color: BrandColors.colorButton ,

              onSelected: (value) {
               if(value == 'profile'){
                 Get.toNamed(profileScreen);
               }
              else if(value == 'default_reply'){
                Get.toNamed(defaultScreen);
                }else if(value == 'welcome'){
                 Get.toNamed(welcomeScreen);
               }
               else if(value == 'block'){
                 Get.toNamed(blockScreen);
               } else {

                 final AuthController _googleController = Get.put(AuthController());
                 _googleController.signOut();

               }


              },
              itemBuilder: (BuildContext context) {
                return const [
                  PopupMenuItem(
                    child: Text("Profile",style: TextStyle(color: BrandColors.backgroundColor),),
                    value: 'profile',
                  ),
                  PopupMenuItem(
                    child: Text("Welcome message",style: TextStyle(color: BrandColors.backgroundColor),),
                    value: 'welcome',
                  ),
                  PopupMenuItem(
                    child: Text("Default Reply",style: TextStyle(color: BrandColors.backgroundColor),),
                    value: 'default_reply',
                  ),

                  PopupMenuItem(
                    child: Text("Block",style: TextStyle(color: BrandColors.backgroundColor),),
                    value: 'block',
                  ),
                  PopupMenuItem(
                    child: Text("Log Out",style: TextStyle(color: BrandColors.backgroundColor),),
                    value: 'logout',
                  ),
                ];
              }),
          Gap(10.w),
        ],
        bottom: TabBar(
          tabs: topTabs,
          controller: tabController,
          indicatorColor: BrandColors.colorButton,
          labelColor:BrandColors.colorButton ,
          unselectedLabelColor: BrandColors.greyColor,
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          AllChatPage(),
          UnreadChatPage(),
          UnAnsweredChatPage(),

        ],
      ),
    );
  }
}