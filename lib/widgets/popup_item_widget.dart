import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/text_font_style.dart';

class PopupWidget extends StatefulWidget {
  const PopupWidget({Key? key, required this.language}) : super(key: key);
  final TextEditingController language;

  @override
  State<PopupWidget> createState() => _PopupWidgetState();
}

class _PopupWidgetState extends State<PopupWidget> {
  String _value = "Portuguese";
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
            style:TextFontStyle.popUpselectedText.copyWith(color: Colors.white) ,
          ),
          PopupMenuButton<String>(
            key: _popUpGlobalkey,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.white,
            ),
            iconSize: 25.r,
            onSelected: (String value) {
              setState(() {
                _value = value;
                widget.language.text = value;
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
                value: 'English',
                child: Text(
                  'English',
                  style: TextFontStyle.popUpselectedText,
                ),
              ),
              PopupMenuItem(
                value: 'Portuguese',
                child: Text(
                  'Portuguese',
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
