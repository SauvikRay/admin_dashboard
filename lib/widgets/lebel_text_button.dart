import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getwidget/getwidget.dart';

import '../constants/app_color.dart';
import '../constants/text_font_style.dart';

class LabelTextButton extends StatelessWidget {
  LabelTextButton({
    Key? key,
    required this.onCallBack,
    required this.text,
    required this.icon,
    this.width = 130,
    this.height = 30,
    this.color = AppColors.primaryColor,
    this.borderSide,
    this.textFontStyle, //TextFontStyle.buttonBoldStyle,
  }) : super(key: key);
  final VoidCallback onCallBack;
  final String text;
  final Widget icon;
  final double width;
  final double height;
  Color color;
  BorderSide? borderSide;
  TextStyle? textFontStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: GFButton(
        borderSide: borderSide,
        shape: GFButtonShape.standard,
        color: color,
        onPressed: onCallBack,
        icon: icon,
        text: text,
        textStyle: textFontStyle ?? TextFontStyle.buttonBoldStyle,
      ),
    );
  }
}
