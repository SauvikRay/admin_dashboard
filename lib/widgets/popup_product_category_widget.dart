import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/networks/api_acess.dart';
import '/networks/rx_product_category/rx.dart';
import '/widgets/loading_indicators.dart';

import '../constants/text_font_style.dart';

class ProductCategoryPopupWidget extends StatefulWidget {
  ProductCategoryPopupWidget(
      {Key? key, required this.productCategory, required this.value})
      : super(key: key);
  final TextEditingController productCategory;
  String value;

  @override
  State<ProductCategoryPopupWidget> createState() =>
      _ProductCategoryPopupWidgetState();
}

class _ProductCategoryPopupWidgetState
    extends State<ProductCategoryPopupWidget> {
  final _popUpGlobalkey = GlobalKey<PopupMenuButtonState<dynamic>>();
  String _value = "Select";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _popUpGlobalkey.currentState!.showButtonMenu();
      },
      child: StreamBuilder(
        stream: getProductCategoryRXobj.getProductCategoryData,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<dynamic> data = snapshot.data["data"]["productCategory"];
            List<dynamic> statusData = [];
            for (var element in data) {
              if (element['status'] == 1) {
                statusData.add(element);
              }
            }
            // for (int i = 0; i <= data.length; i++) {
            //   String status = data[i]["status"].toString();
            //   int a = int.parse(status);
            //   if (a == 1) {
            //     count++;
            //     print("count is $count");

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
                    color: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    // position: PopupMenuPosition.over,
                    offset: const Offset(-220, 0),
                    onSelected: (Map value) {
                      setState(() {
                        int productCatedoryId = value["id"];
                        _value = value["name"];
                        widget.value = _value.toString();
                        widget.productCategory.text =
                            productCatedoryId.toString();
                        log("The id is " + value["id"].toString());
                      });
                    },
                    itemBuilder: (context) {
                      return List.generate(growable: true, statusData.length,
                          (index) {
                        return PopupMenuItem(
                          value: {
                            "id": statusData[index]["id"],
                            "name": statusData[index]["name"]
                          },
                          child: Text(
                            statusData[index]["name"],
                            style: TextFontStyle.popUpselectedText
                                .copyWith(color: Colors.black),
                          ),
                        );
                      });
                    }),
              ],
            );
          } else if (snapshot.hasError) {
            return loadingIndicatorCircle(context: context);
          }
          return const SizedBox.shrink();
          // }
        },
      ),
    );
  }
}
