import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/text_font_style.dart';

class GroupPopupWidget extends StatefulWidget {
  GroupPopupWidget(
      {Key? key, required this.groupPopupText, required this.value})
      : super(key: key);
  TextEditingController groupPopupText;
  String value;

  @override
  State<GroupPopupWidget> createState() => _GroupPopupWidgetState();
}

class _GroupPopupWidgetState extends State<GroupPopupWidget> {
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
            widget.value,
            style:
                TextFontStyle.popUpselectedText.copyWith(color: Colors.black),
          ),
          PopupMenuButton<int>(
            key: _popUpGlobalkey,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black,
            ),
            iconSize: 25.r,
            onSelected: (int val) {
              setState(() {
                switch (val) {
                  case 1:
                    widget.value = 'WEDE ESTREMOZ';
                    break;
                  case 2:
                    widget.value = 'WEDE MONTEMOR';
                    break;
                  case 3:
                    widget.value = 'WEDE COMPORTA';
                    break;
                  case 4:
                    widget.value = 'WEDE EVORA';
                    break;
                  case 5:
                    widget.value = 'WEDE SANTIAGO DO CACEM';
                    break;
                  case 6:
                    widget.value = 'WEDE REGUENGOS DE MONSARAZ';
                    break;
                  case 7:
                    widget.value = 'WEDE VENDAS NOVAS';
                    break;
                  default:
                    "";
                    break;
                }
                widget.groupPopupText.text = val.toString();
              });
            },
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            // position: PopupMenuPosition.over,
            offset: const Offset(-220, 0),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Text(
                  'WEDE ESTREMOZ',
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  'WEDE MONTEMOR',
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Text(
                  'WEDE COMPORTA',
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Text(
                  'WEDE EVORA',
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: 5,
                child: Text(
                  'WEDE SANTIAGO DO CACEM',
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: 6,
                child: Text(
                  'WEDE REGUENGOS DE MONSARAZ',
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: 7,
                child: Text(
                  'WEDE VENDAS NOVAS',
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
              ),
              PopupMenuItem(
                value: 7,
                child: Text(
                  'WEDE TROIA',
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
