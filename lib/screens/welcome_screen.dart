import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '/constants/app_color.dart';

import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40.h,
                ),
                // Image.asset(
                //   AssetIcons.user,
                //   height: 130.h,
                //   width: 130.h,
                // ),
                // SizedBox(
                //   height: 40.h,
                // ),
                // Image.asset(
                //   'assets/images/rose_rosa.png',
                //   height: 130.h,
                //   width: 130.h,
                // ),
                // SizedBox(
                //   height: 40.h,
                // ),
                SvgPicture.asset(AssetIcons.splash),
                // SizedBox(
                //   height: 20.h,
                // ),
                // Text(
                //   'CONTESTA',
                //   textAlign: TextAlign.center,
                //   style: TextFontStyle.welcome,
                // ),
                // Text(
                //   'NA HORA',
                //   textAlign: TextAlign.center,
                //   style: TextFontStyle.welcome,
                // ),
                SizedBox(
                  height: 20.h,
                ),
              ]),
        ),
      ),
    );
  }
}
