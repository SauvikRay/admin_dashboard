import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_color.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.icon,
    this.buttonWidget,
    required this.numText,
    required this.text,
  }) : super(key: key);
  final Widget icon;
  final Widget? buttonWidget;
  final String numText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110.h,
      width: double.infinity,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        shadowColor: Colors.grey.withOpacity(0.7),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        elevation: 2.0,
        color: AppColors.white,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 65.h,
                width: 65.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: AppColors.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.7),
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 0.2, //extend the shadow
                      offset: const Offset(
                        1, // Move to right 10  horizontally
                        1, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                child: icon,
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: buttonWidget != null
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.end,
                children: [
                  Flexible(
                    flex: 3,
                    child: Text(
                      numText,
                      style: TextFontStyle.headline2BoldStyle
                          .copyWith(color: AppColors.headLine2Color),
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  Flexible(
                    flex: 3,
                    child: Text(
                      text,
                      style: TextFontStyle.headline2BoldStyle,
                    ),
                  ),
                  UIHelper.verticalSpaceSmall,
                  if (buttonWidget != null)
                    Flexible(
                      flex: 5,
                      child: buttonWidget!,
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
