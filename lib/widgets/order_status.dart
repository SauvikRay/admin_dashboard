import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/text_font_style.dart';
import '../helpers/helper.dart';

class OrderStatus extends StatelessWidget {
  final String? title;
  final String status;
  final String statuscode;
  final StatusType statusType;
  const OrderStatus({
    Key? key,
    this.title,
    required this.status,
    required this.statuscode,
    required this.statusType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (title != null)
          Text(
            "$title : ",
            style: TextFontStyle.mobileSemiBold,
          ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: statuscolor(statusType, statuscode),
          ),
          child: Text(
            status,
            style: TextFontStyle.mobileBold.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
