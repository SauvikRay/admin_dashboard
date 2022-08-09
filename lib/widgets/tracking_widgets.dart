import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';

class TrackingWidget extends StatelessWidget {
  TrackingWidget(
      {Key? key,
      required this.title,
      required this.time,
      required this.lastVal})
      : super(key: key);

  String title;
  String time;
  bool lastVal;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lastVal
            ? SvgPicture.asset(
                AssetIcons.shortLine,
                width: 8,
              )
            : SvgPicture.asset(
                AssetIcons.line,
                width: 8,
              ),
        UIHelper.horizontalSpaceSmall,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextFontStyle.headline1RegularStyle
                  .copyWith(color: Colors.black.withOpacity(0.8)),
            ),
            UIHelper.verticalSpaceSmall,
            Text(
              time,
              style: TextFontStyle.headline1RegularStyle
                  .copyWith(color: Colors.black.withOpacity(0.8)),
            ),
          ],
        ),
      ],
    );
  }
}
