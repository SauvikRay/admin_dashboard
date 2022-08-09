import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import '/constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../networks/api_acess.dart';
import 'loading_indicators.dart';

class CategoryGroupPopupWidget extends StatefulWidget {
  CategoryGroupPopupWidget(
      {Key? key, required this.categorygroupPopupText, required this.value})
      : super(key: key);

  final TextEditingController categorygroupPopupText;
  String value;

  @override
  State<CategoryGroupPopupWidget> createState() =>
      _CategoryGroupPopupWidgetState();
}

class _CategoryGroupPopupWidgetState extends State<CategoryGroupPopupWidget> {
  final _popUpGlobalkey = GlobalKey<PopupMenuButtonState<dynamic>>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _popUpGlobalkey.currentState!.showButtonMenu();
      },
      child: StreamBuilder(
        stream: getShopCategoryPopupListRXobj.getShopCategoryPopupListData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = snapshot.data["data"]["categories"];
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.value,
                  style: TextFontStyle.popUpselectedText
                      .copyWith(color: Colors.black),
                ),
                PopupMenuButton<Map>(
                  key: _popUpGlobalkey,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.black,
                  ),
                  iconSize: 25.r,
                  onSelected: (Map val) {
                    setState(() {
                      int categoriesID = val["id"];
                      widget.value = val["name"];
                      getShopSubCategoryPopUpListRXobj
                          .fetchSubCategoryData(categoriesID.toString());
                      widget.categorygroupPopupText.text =
                          categoriesID.toString();
                      log("The id is " + val["id"].toString());
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
                  itemBuilder: (context) => List.generate(
                    growable: true,
                    data.length,
                    (index) => PopupMenuItem(
                      value: {
                        "id": data[index]["id"],
                        "name": data[index]["name"]
                      },
                      child: Text(
                        data[index]["name"],
                        style: TextFontStyle.popUpselectedText
                            .copyWith(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: loadingIndicatorCircle(context: context),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
