import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';

/// Contains useful consts to reduce boilerplate and duplicate code
class UIHelper {
  // Vertical spacing constants. Adjust to your liking.
  static final double _verticalSpaceSmall = 10.0.w;
  static final double _verticalSpaceMedium = 20.0.w;
  static final double _verticalSpaceSemiLarge = 40.0.w;
  static final double _verticalSpaceLarge = 60.0.w;
  static final double _verticalSpaceExtraLarge = 100.0.w;

  // Vertical spacing constants. Adjust to your liking.
  static final double _horizontalSpaceSmall = 10.0.h;
  static final double _horizontalSpaceMedium = 20.0.h;
  static final double _horizontalSpaceSemiLarge = 40.0.h;
  static final double _horizontalSpaceLarge = 60.0.h;

  static Widget verticalSpaceSmall = SizedBox(height: _verticalSpaceSmall);
  static Widget verticalSpaceMedium = SizedBox(height: _verticalSpaceMedium);
  static Widget verticalSpaceSemiLarge =
      SizedBox(height: _verticalSpaceSemiLarge);
  static Widget verticalSpaceLarge = SizedBox(height: _verticalSpaceLarge);
  static Widget verticalSpaceExtraLarge =
      SizedBox(height: _verticalSpaceExtraLarge);

  static Widget horizontalSpaceSmall = SizedBox(width: _horizontalSpaceSmall);
  static Widget horizontalSpaceMedium = SizedBox(width: _horizontalSpaceMedium);
  static Widget horizontalSpaceSemiLarge =
      SizedBox(width: _horizontalSpaceSemiLarge);
  static Widget horizontalSpaceLarge = SizedBox(width: _horizontalSpaceLarge);

  static Widget horizontalSpace(double width) => SizedBox(width: width);
  static Widget verticalSpace(double height) => SizedBox(height: height);

  static Widget customDivider() => Container(
        height: 1.h,
        color: AppColors.disabledColor,
        width: double.infinity,
      );
  static double kDefaulutPadding() => 10.w;
}
