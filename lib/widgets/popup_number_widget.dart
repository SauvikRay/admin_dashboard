import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '/constants/app_color.dart';
import '/constants/app_constants.dart';
import '../constants/text_font_style.dart';

class PopupNumberWidget extends StatefulWidget {
  const PopupNumberWidget({Key? key, required this.number}) : super(key: key);
  final TextEditingController number;

  @override
  State<PopupNumberWidget> createState() => _PopupNumberWidgetState();
}

class _PopupNumberWidgetState extends State<PopupNumberWidget> {
  String _value = '10';
  final _popUpGlobalkey = GlobalKey<PopupMenuButtonState<String>>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _popUpGlobalkey.currentState!.showButtonMenu();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _value,
            style: TextFontStyle.popUpselectedText
                .copyWith(color: AppColors.headLine1Color),
          ),
          PopupMenuButton<String>(
            key: _popUpGlobalkey,
            splashRadius: 10.r,
            icon: SvgPicture.asset(
              AssetIcons.sates,
              color: AppColors.primaryColor,
            ),
            iconSize: 25.r,
            onSelected: (String value) {
              setState(() {
                _value = value;
                widget.number.text = value;
              });
            },
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            offset: const Offset(0, kToolbarHeight),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: '10',
                height: 25.h,
                child: Text(
                  '10',
                  style: TextFontStyle.popUpselectedText,
                ),
              ),
              PopupMenuItem(
                value: '25',
                height: 25.h,
                child: Text(
                  '25',
                  style: TextFontStyle.popUpselectedText,
                ),
              ),
              PopupMenuItem(
                value: '50',
                height: 25.h,
                child: Text(
                  '50',
                  style: TextFontStyle.popUpselectedText,
                ),
              ),
              PopupMenuItem(
                value: '100',
                height: 25.h,
                child: Text(
                  '100',
                  style: TextFontStyle.popUpselectedText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
