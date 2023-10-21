
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:wow_chat_app/src/screen/1st_page/splash.dart';
import 'package:wow_chat_app/src/screen/widgets/colors.dart';
import 'package:wow_chat_app/src/service/binding/binding.dart';
import 'package:wow_chat_app/src/service/init/init.dart';
import 'package:wow_chat_app/src/service/route/route.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Wow Chat',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(
            hintColor: Colors.grey.withOpacity(0.8),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:  const BorderSide(color:Colors.deepPurple)
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide:  const BorderSide(color:Colors.red)
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                  borderSide: const BorderSide(
                      color: Colors.red
                  )
              ),
              hintStyle: myStyle(15,),
              labelStyle: myStyle(15, const Color.fromARGB(234, 70, 69, 69)),
            )
          ),
          getPages: getPages,
          initialBinding: AppBindings(),
          initialRoute: splashScreen,


        );
      },
      child:  SplashScreen(),
    );
  }
}