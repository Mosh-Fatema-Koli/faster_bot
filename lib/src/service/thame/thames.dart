//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class Themes{
//
//   static  ThemeData themeData(BuildContext context,bool isDarkMode)=>ThemeData(
//       scaffoldBackgroundColor:!isDarkMode?AppColors.bgColor :AppColors.darkBgColor,
//       primaryColor: AppColors.mainColor,
// //  secondaryHeaderColor: Color(0xFF009f67),
//       //   fontFamily: "Metropolis",
//
//       brightness: isDarkMode?Brightness.dark:Brightness.light,
//       disabledColor:AppColors.greyColor,
//       hintColor: AppColors.greyColor,
//       dividerColor:isDarkMode?AppColors.borderColor.withOpacity(0.05):AppColors.borderColor,
//       shadowColor:AppColors.shadowColor,
//       canvasColor:isDarkMode?const Color(0xFF2c2c2c):Colors.white,
//       cardColor:isDarkMode?AppColors.darkCardColor:AppColors.cardColor,
//
//       iconTheme: IconThemeData(
//         color:isDarkMode?AppColors.darkIconColor:AppColors.iconColor,
//       ),
//
//
//       textTheme: Theme.of(context).textTheme.apply(
//         bodyColor:!isDarkMode?AppColors.textColor:AppColors.darkTextColor,
//         // displayColor: Colors.blue,
//       ),
//
//       inputDecorationTheme: InputDecorationTheme(
//         fillColor:isDarkMode?AppColors.darkFillColor:AppColors.fillColor,
//         focusedBorder: OutlineInputBorder(
//           borderRadius:
//           BorderRadius.circular(5.r), // Adjust the border radius as needed
//           borderSide: BorderSide(color:Colors.white.withOpacity(0.5)), // Remove the border
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius:
//           BorderRadius.circular(5.r), // Adjust the border radius as needed
//           borderSide: BorderSide(color:Colors.white.withOpacity(0.1)), // Remove the border
//         ),
//         errorBorder:OutlineInputBorder(
//           borderRadius:
//           BorderRadius.circular(5.r), // Adjust the border radius as needed
//           borderSide: const BorderSide(color:Colors.red), // Remove the border
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius:
//           BorderRadius.circular(5.r), // Adjust the border radius as needed
//           borderSide: const BorderSide(color: Colors.red), // Remove the border
//         ),
//       ),
//
//       appBarTheme: AppBarTheme(
//         backgroundColor:!isDarkMode?AppColors.bgColor: AppColors.darkFillColor,
//         iconTheme: IconThemeData(color:!isDarkMode?AppColors.iconColor:AppColors.darkIconColor,size:24.sp,),
//         titleTextStyle: TextStyle(color:!isDarkMode?AppColors.textColor:AppColors.darkTextColor ),
//         elevation:1,
//         centerTitle: true,
//       ),
//
//   );
//
//
//   buildOutlineInputBorder(Color color) {
//     return OutlineInputBorder(
//       borderRadius:
//       BorderRadius.circular(5.r), // Adjust the border radius as needed
//       borderSide: BorderSide(color: color), // Remove the border
//     );
//   }
//
//
// }
//
//
//
