import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../constants/app_color.dart';

Widget loadingIndicatorCircle({
  required BuildContext context,
  Color? color,
  double? size,
}) {
  double loaderSize = 50.sp;
  return Center(
    child: SpinKitFadingCircle(
      color: color ?? AppColors.primaryColor,
      size: size ?? loaderSize,
    ),
  );
}
