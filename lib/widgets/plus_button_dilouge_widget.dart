import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:wede_restaurant/helpers/navigation_service.dart';

import '../constants/app_color.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../networks/api_acess.dart';
import 'custom_button.dart';
import 'custome_textfield.dart';

List<MultiSelectItem<Animal>> animalLst = [];
List<Animal> selectedList = [];
List<Animal> animals = [];

Widget plusButtonDialouge(
    BuildContext context, List<dynamic> delieryBoy, List<dynamic> selecTedVal) {
  TextEditingController radiusController = TextEditingController();
  log(delieryBoy.toString());
  return Dialog(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),

      // height: 400.h,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 500.h, maxWidth: 500.w),
        child: Column(
          children: [
            Text(
              'Loja(fresh-new-shop)',
              style: TextFontStyle.headline1BoldStyle
                  .copyWith(color: Colors.black),
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Text(
                  'Designar estafeta *',
                  style: TextFontStyle.headline2BoldStyle,
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: AppColors.disabledColor.withOpacity(0.1),
                    spreadRadius: 0.5,
                    blurRadius: 7,
                    offset: const Offset(0.0, 1.0),
                  ),
                ]),
                child: SubCategoryPopupList(
                  initVal: delieryBoy,
                  selectedVal: selecTedVal,
                )),
            UIHelper.verticalSpaceMedium,
            //Gravar Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeButton(
                    name: 'Submeter',
                    onCallBack: () {
                      List<dynamic> list = List<dynamic>.generate(
                          selectedList.length, (i) => selectedList[i].id);
                      postDeliveyBoyListRX.postDeliveyBoyList(list);
                      getShopDeliveyBoyRXobj.fetchGetShopDeliveyBoyData();
                      NavigationService.goBack;
                    },
                    height: 0.050.sh,
                    minWidth: 125.w,
                    borderRadius: 8.r,
                    color: AppColors.primaryColor,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
                UIHelper.horizontalSpaceSmall,
                //Cancelar
                customeButton(
                    name: 'Cancelar',
                    onCallBack: () {
                      NavigationService.goBack;
                    },
                    height: 0.050.sh,
                    minWidth: 125.w,
                    borderRadius: 8.r,
                    color: AppColors.headLine1Color,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class SubCategoryPopupList extends StatefulWidget {
  SubCategoryPopupList(
      {Key? key, required this.initVal, required this.selectedVal})
      : super(key: key);
  List<dynamic> initVal;
  List<dynamic> selectedVal;

  @override
  State<SubCategoryPopupList> createState() => _SubCategoryPopupListState();
}

class _SubCategoryPopupListState extends State<SubCategoryPopupList> {
  @override
  void initState() {
    setState(() {
      animals = List<Animal>.generate(
        widget.initVal.length,
        (i) => Animal(
            id: widget.initVal[i]["id"],
            name: widget.initVal[i]["name"] + widget.initVal[i]["email"]),
      );
      animalLst = animals
          .map((animal) => MultiSelectItem(animal, animal.name!))
          .toList();
      selectedList = List<Animal>.generate(
        widget.selectedVal.length,
        (i) => Animal(
            id: widget.selectedVal[i]["id"],
            name: widget.selectedVal[i]["first_name"] +
                widget.selectedVal[i]["email"]),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: MultiSelectDialogField<Animal>(
        items: animalLst,
        initialValue: selectedList,
        separateSelectedItems: true,
        buttonIcon: const Icon(Icons.arrow_drop_down),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0.r),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1.5,
          ),
        ),
        searchHint: 'Sede Santiago Do Cacém',
        listType: MultiSelectListType.LIST,
        searchable: true,
        onConfirm: (values) {
          setState(() {
            selectedList = values;
            selectedList.forEach(
              (element) {
                log(element.id.toString() + element.name.toString());
              },
            );
          });
        },
      ),
    );
  }
}

class Animal {
  int? id;
  String? name;
  Animal({this.id, this.name});
}
