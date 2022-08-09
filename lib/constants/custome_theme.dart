import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

class CustomTheme {
  BuildContext? context;

  static ThemeData get mainTheme {
    return ThemeData(
      // dividerTheme: const DividerThemeData(
      //   color: AppColors.deviderColor,
      // ),
      primaryColor: AppColors.primaryColor,
      primarySwatch: AppColors.kToDark,
      scaffoldBackgroundColor: AppColors.scaffoldColor,
      //fontFamily: 'Montserrat',
      // textTheme: TextTheme(
      //   //  final head1 = Theme.of(context).textTheme.headline1;
      //   //  final head2 = Theme.of(context).textTheme.headline2;
      //   //  final head3 = Theme.of(context).textTheme.headline3;
      //   // final head4 = Theme.of(context).textTheme.headline4;
      //   // final head5 = Theme.of(context).textTheme.headline5;
      //   // final body1 = Theme.of(context).textTheme.bodyText1;
      //   // final body2 = Theme.of(context).textTheme.bodyText2;
      //   // final sub1 = Theme.of(context).textTheme.subtitle1;
      //   // final sub2 = Theme.of(context).textTheme.subtitle2;

      //   //  headline1: TextStyle(fontSize:24.sp,fontWeight: FontWeight.bold,),
      //   //  headline2: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,),
      //   //  headline3: TextStyle(fontSize:18.sp,fontWeight: FontWeight.normal,),
      //   //  headline4: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,),
      //   //  headline5: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold,),
      //   //  headline6: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal,),
      //   //  bodyText1:  TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,),
      //   subtitle1: TextStyle(
      //     fontSize: 12.sp,
      //     fontWeight: FontWeight.bold,
      //   ),
      //   subtitle2: TextStyle(
      //     fontSize: 12.sp,
      //     fontWeight: FontWeight.normal,
      //   ),

      //   button: TextStyle(
      //       fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),
      // ),

      // //TabBar Theme
      // tabBarTheme: TabBarTheme(
      //   labelColor: AppColors.highLightText,
      //   labelStyle: TextStyle(fontSize:18.sp,fontWeight: FontWeight.bold),
      //   labelPadding: EdgeInsets.only(bottom: 20.h),
      //   unselectedLabelColor: Colors.black,
      //   unselectedLabelStyle: TextStyle(fontSize:18.sp,fontWeight: FontWeight.bold),
      //   //indicatorWeight: 5.h,
      //   indicator: UnderlineTabIndicator(
      //     borderSide: BorderSide(width: 5.h,color: AppColors.highLightText)
      //   ),

      // ),

      //AppBar Theme
      // appBarTheme: AppBarTheme(

      //   // backgroundColor: Colors.black,
      //   color: Colors.black,
      //   elevation: 2,

      //   titleTextStyle: TextStyle(
      //       fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
      //   iconTheme: const IconThemeData(
      //     color: Colors.white,
      //   ),

      // ),

      //   buttonTheme: ButtonThemeData(

      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      //   buttonColor:const Color(0xFF6B34BE),
      //   height: 60,
      //   minWidth: double.infinity,
      // ),

      //Drawer
    );
  }
}
