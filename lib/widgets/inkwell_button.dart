import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_color.dart';

class InkWellButton extends StatelessWidget {
  InkWellButton(
      {Key? key,
      required this.icon,
      required this.onCallBack,
      this.width,
      this.height})
      : super(key: key);
  final String icon;
  final VoidCallback onCallBack;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(5.r),
      splashColor: AppColors.disabledColor,
      onTap: onCallBack,
      child: SvgPicture.asset(
        icon,
        width: width,
        height: height,
      ),
    );
  }
}
