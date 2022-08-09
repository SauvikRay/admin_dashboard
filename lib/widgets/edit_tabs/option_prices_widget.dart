import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wede_restaurant/helpers/navigation_service.dart';
import 'package:wede_restaurant/widgets/loading_indicators.dart';
import '/constants/ui_helpers.dart';
import '/helpers/di.dart';
import '/helpers/table_model/food_options_id.dart';

import '../../constants/app_color.dart';
import '../../constants/app_constants.dart';
import '../../constants/text_font_style.dart';
import '../../networks/api_acess.dart';
import '../lebel_text_button.dart';

class OptionAndPrices extends StatefulWidget {
  const OptionAndPrices({Key? key}) : super(key: key);

  @override
  State<OptionAndPrices> createState() => _OptionAndPricesState();
}

class _OptionAndPricesState extends State<OptionAndPrices> {
  bool isChecked = false;

  late int restaurantfoodId;
  int _count = 1;
  List<dynamic> _items = [];
  bool isLoading = true;

  @override
  void initState() {
    dataLoading();
    super.initState();
  }

  dataLoading() async {
    if (locator<FoodId>().getFoodId != null) {
      restaurantfoodId = locator<FoodId>().getFoodId!;

      await getProductShowRxobj
          .fetchProductShowData(restaurantfoodId.toString());
      if (restaurantfoodId.isNaN == false) {
        getProductShowRxobj.getProductShowData.first.then((event) {
          Map data = event['data']['food'];
          _items = data['options'];

          log(_items.toString());

          setState(() {
            isLoading = false;
            _count = _items.length;
          });
        });
      }
    } else {
      setState(() {
        isLoading = false;
        _count = _items.length;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      primary: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (ScreenUtil().screenWidth < 600)
              ? Column(
                  children: [
                    isLoading
                        ? loadingIndicatorCircle(context: context)
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                UIHelper.verticalSpaceMedium,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _count,
                            itemBuilder: (context, index) {
                              final TextEditingController optionNameController =
                                  TextEditingController();
                              final TextEditingController priceController =
                                  TextEditingController();
                              final TextEditingController
                                  descriptionController =
                                  TextEditingController();

                              int? optionId = _items[index]['id']! ?? null;
                              // log(id);
                              String name =
                                  _items[index]['name']!.toString() ?? "";
                              // log(name);
                              optionNameController.text = name;
                              // log(optionNameController.text);
                              String price =
                                  _items[index]['price']!.toString() ?? "";
                              priceController.text = price;

                              String description =
                                  _items[index]['description'].toString() ?? "";
                              descriptionController.text = description;
                              bool isDefault = _items[index]['is_default']! == 1
                                  ? true
                                  : false;

                              return mobileFormCardWidget(
                                  optionId!,
                                  name,
                                  price,
                                  isDefault,
                                  description,
                                  optionNameController,
                                  priceController,
                                  descriptionController);
                            },
                          ),
                    UIHelper.verticalSpaceMedium,
                  ],
                )
              : Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text("Option Name",
                              style: TextFontStyle.tableHeader,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                        ),
                        UIHelper.horizontalSpaceMedium,
                        Expanded(
                          child: Text("Price",
                              style: TextFontStyle.tableHeader,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                        ),
                        UIHelper.horizontalSpaceMedium,
                        Expanded(
                          child: Text("Is Default?",
                              style: TextFontStyle.tableHeader,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                        ),
                        UIHelper.horizontalSpaceMedium,
                        Expanded(
                          child: Text("Description",
                              style: TextFontStyle.tableHeader,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                        ),
                        UIHelper.horizontalSpaceMedium,
                        Expanded(
                          child: Text("Actions",
                              style: TextFontStyle.tableHeader,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceMedium,
                    isLoading
                        ? loadingIndicatorCircle(context: context)
                        : ListView.separated(
                            separatorBuilder: (context, index) =>
                                UIHelper.verticalSpaceMedium,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _count,
                            itemBuilder: (context, index) {
                              final TextEditingController optionNameController =
                                  TextEditingController();
                              final TextEditingController priceController =
                                  TextEditingController();
                              final TextEditingController
                                  descriptionController =
                                  TextEditingController();

                              int? optionId = _items[index]['id']! ?? null;
                              // log(id);
                              String name =
                                  _items[index]['name']!.toString() ?? "";
                              // log(name);
                              optionNameController.text = name;
                              // log(optionNameController.text);
                              String price =
                                  _items[index]['price']!.toString() ?? "";
                              priceController.text = price;

                              String description =
                                  _items[index]['description'].toString() ?? "";
                              descriptionController.text = description;
                              bool isDefault = _items[index]['is_default']! == 1
                                  ? true
                                  : false;

                              return newFormWidget(
                                  optionId!,
                                  name,
                                  price,
                                  isDefault,
                                  description,
                                  optionNameController,
                                  priceController,
                                  descriptionController);
                            },
                          ),
                    UIHelper.verticalSpaceMedium,
                  ],
                ),
          UIHelper.verticalSpaceMedium,
          Align(
            alignment: Alignment.bottomRight,
            child: LabelTextButton(
              width: 400.w,
              icon: SvgPicture.asset(AssetIcons.buttonPlusIcon),
              onCallBack: () async {
                final TextEditingController optionNameController =
                    TextEditingController();
                final TextEditingController priceController =
                    TextEditingController();
                final TextEditingController descriptionController =
                    TextEditingController();

                // log(id);
                String name;
                // log(name);

                // log(optionNameController.text);
                String price;

                String description;

                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w,
                              top: 10.h,
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  10.h),
                          child: (ScreenUtil().screenWidth < 600)
                              ? SizedBox(
                                  height: .42.sh,
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text("Option Name",
                                              style: TextFontStyle.tableHeader,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left),
                                          UIHelper.horizontalSpaceSmall,
                                          Expanded(
                                            child: TextFormField(
                                              controller: optionNameController,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1.0,
                                                        horizontal: 20),
                                                hintText: 'Insert Name',
                                                hintStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      AppColors.disabledColor,
                                                ),
                                                //labelText: labelText,
                                                labelStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w100,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      AppColors.disabledColor,
                                                ),
                                                errorStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w100,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.disabledColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                              ),
                                              style: TextStyle(
                                                letterSpacing: 1.5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w100,
                                                fontStyle: FontStyle.normal,
                                                color: AppColors.disabledColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpaceMedium,
                                      Row(
                                        children: [
                                          Text("Price",
                                              style: TextFontStyle.tableHeader,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left),
                                          UIHelper.horizontalSpaceSmall,
                                          Expanded(
                                            child: TextFormField(
                                              controller: priceController,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1.0,
                                                        horizontal: 20),
                                                hintText: 'Price',
                                                hintStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      AppColors.disabledColor,
                                                ),
                                                //labelText: labelText,
                                                labelStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w100,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      AppColors.disabledColor,
                                                ),
                                                errorStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w100,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.disabledColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                              ),
                                              style: TextStyle(
                                                letterSpacing: 1.5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w100,
                                                fontStyle: FontStyle.normal,
                                                color: AppColors.disabledColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpaceMedium,
                                      Row(
                                        children: [
                                          Text("Is default",
                                              style: TextFontStyle.tableHeader,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left),
                                          UIHelper.horizontalSpaceSmall,
                                          Transform.scale(
                                            scale: 1.2,
                                            child: Checkbox(
                                              activeColor:
                                                  AppColors.primaryColor,
                                              value: isChecked,
                                              onChanged: (value) async {
                                                setState(() {
                                                  isChecked = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpaceMedium,
                                      Row(
                                        children: [
                                          Text("Description",
                                              style: TextFontStyle.tableHeader,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left),
                                          UIHelper.horizontalSpaceSmall,
                                          Expanded(
                                            child: TextFormField(
                                              controller: descriptionController,
                                              decoration: InputDecoration(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1.0,
                                                        horizontal: 20),
                                                hintText: 'Description',
                                                hintStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      AppColors.disabledColor,
                                                ),
                                                //labelText: labelText,
                                                labelStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w100,
                                                  fontStyle: FontStyle.normal,
                                                  color:
                                                      AppColors.disabledColor,
                                                ),
                                                errorStyle: TextStyle(
                                                  letterSpacing: 1,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w100,
                                                  fontStyle: FontStyle.normal,
                                                  color: Colors.red,
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.disabledColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color: Colors.red,
                                                    width: 1.5,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          2.0.r),
                                                  borderSide: const BorderSide(
                                                    color:
                                                        AppColors.borderColor,
                                                    width: 1.5,
                                                  ),
                                                ),
                                              ),
                                              style: TextStyle(
                                                letterSpacing: 1.5,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w100,
                                                fontStyle: FontStyle.normal,
                                                color: AppColors.disabledColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpaceMedium,
                                      InkWell(
                                        child: Icon(
                                          Icons.save,
                                          size: 40.sp,
                                        ),
                                        onTap: () async {
                                          Map e = _items.firstWhere((element) =>
                                              element['is_default'] == 1);
                                          await postProductPriceRXobj
                                              .postProductPriceData(
                                            optionNameController.text,
                                            priceController.text,
                                            isChecked ? 1 : 0,
                                            descriptionController.text,
                                            restaurantfoodId,
                                          );
                                          if (e != null && isChecked) {
                                            await postProductPriceRXobj
                                                .postProductPriceData(
                                                    e['name'],
                                                    e['price'],
                                                    0,
                                                    e['description'],
                                                    e['restaurant_food_id'],
                                                    optionId: e['id']);
                                          }
                                          NavigationService.goBack;
                                          dataLoading();
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              : Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: optionNameController,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 1.0,
                                                  horizontal: 20),
                                          hintText: 'Insert Name',
                                          hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.disabledColor,
                                          ),
                                          //labelText: labelText,
                                          labelStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w100,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.disabledColor,
                                          ),
                                          errorStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w100,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.red,
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.disabledColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          letterSpacing: 1.5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w100,
                                          fontStyle: FontStyle.normal,
                                          color: AppColors.disabledColor,
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpaceMedium,
                                    Expanded(
                                      child: TextFormField(
                                        controller: priceController,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 1.0,
                                                  horizontal: 20),
                                          hintText: 'Price',
                                          hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.disabledColor,
                                          ),
                                          //labelText: labelText,
                                          labelStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w100,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.disabledColor,
                                          ),
                                          errorStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w100,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.red,
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.disabledColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          letterSpacing: 1.5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w100,
                                          fontStyle: FontStyle.normal,
                                          color: AppColors.disabledColor,
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpaceMedium,
                                    Expanded(
                                      child: Transform.scale(
                                        scale: 1.2,
                                        child: Checkbox(
                                          activeColor: AppColors.primaryColor,
                                          value: isChecked,
                                          onChanged: (value) async {
                                            setState(() {
                                              isChecked = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpaceMedium,
                                    Expanded(
                                      child: TextFormField(
                                        controller: descriptionController,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 1.0,
                                                  horizontal: 20),
                                          hintText: 'Description',
                                          hintStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.disabledColor,
                                          ),
                                          //labelText: labelText,
                                          labelStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w100,
                                            fontStyle: FontStyle.normal,
                                            color: AppColors.disabledColor,
                                          ),
                                          errorStyle: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w100,
                                            fontStyle: FontStyle.normal,
                                            color: Colors.red,
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.disabledColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 1.5,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(2.0.r),
                                            borderSide: const BorderSide(
                                              color: AppColors.borderColor,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          letterSpacing: 1.5,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w100,
                                          fontStyle: FontStyle.normal,
                                          color: AppColors.disabledColor,
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpaceMedium,
                                    Expanded(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            child: Icon(
                                              Icons.save,
                                              size: 40.sp,
                                            ),
                                            onTap: () async {
                                              Map e = _items.firstWhere(
                                                  (element) =>
                                                      element['is_default'] ==
                                                      1);
                                              await postProductPriceRXobj
                                                  .postProductPriceData(
                                                optionNameController.text,
                                                priceController.text,
                                                isChecked ? 1 : 0,
                                                descriptionController.text,
                                                restaurantfoodId,
                                              );
                                              if (e != null && isChecked) {
                                                await postProductPriceRXobj
                                                    .postProductPriceData(
                                                        e['name'],
                                                        e['price'],
                                                        0,
                                                        e['description'],
                                                        e['restaurant_food_id'],
                                                        optionId: e['id']);
                                              }
                                              NavigationService.goBack;
                                              dataLoading();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                        );
                      },
                    );
                  },
                );

                dataLoading();
              },
              text: "Add more options",
            ),
          ),
          UIHelper.verticalSpaceSemiLarge,
        ],
      ),
    );
  }

  newFormWidget(
    int optionId,
    String name,
    String price,
    bool isDefault,
    String description,
    TextEditingController nameController,
    TextEditingController priceController,
    TextEditingController descriptionController,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 20),
                hintText: 'Insert Name',
                hintStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: AppColors.disabledColor,
                ),
                //labelText: labelText,
                labelStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.normal,
                  color: AppColors.disabledColor,
                ),
                errorStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.normal,
                  color: Colors.red,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.disabledColor,
                    width: 1.5,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
              ),
              style: TextStyle(
                letterSpacing: 1.5,
                fontSize: 14.sp,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
                color: AppColors.disabledColor,
              ),
              onChanged: (value) {
                name = value;
              },
            ),
          ),
          UIHelper.horizontalSpaceMedium,
          Expanded(
            child: TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 20),
                hintText: 'Price',
                hintStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: AppColors.disabledColor,
                ),
                //labelText: labelText,
                labelStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.normal,
                  color: AppColors.disabledColor,
                ),
                errorStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.normal,
                  color: Colors.red,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.disabledColor,
                    width: 1.5,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
              ),
              style: TextStyle(
                letterSpacing: 1.5,
                fontSize: 14.sp,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
                color: AppColors.disabledColor,
              ),
              onChanged: (value) {
                price = value;
              },
            ),
          ),
          UIHelper.horizontalSpaceMedium,
          Expanded(
            child: Transform.scale(
              scale: 1.2,
              child: Checkbox(
                activeColor: AppColors.primaryColor,
                value: isDefault,
                onChanged: (value) async {
                  isDefault = value!;
                  Map e = _items
                      .firstWhere((element) => element['is_default'] == 1);
                  log(e.toString());

                  await postProductPriceRXobj.postProductPriceData(
                      name, price, value ? 1 : 0, description, restaurantfoodId,
                      optionId: optionId);
                  // onSaveData(name, price, value!, description,
                  //     restaurantfoodId, optionId);
                  if (e != null) {
                    await postProductPriceRXobj.postProductPriceData(
                        e['name'],
                        e['price'],
                        0,
                        e['description'],
                        e['restaurant_food_id'],
                        optionId: e['id']);
                  }
                  dataLoading();
                },
              ),
            ),
          ),
          UIHelper.horizontalSpaceMedium,
          Expanded(
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 20),
                hintText: 'Description',
                hintStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: AppColors.disabledColor,
                ),
                //labelText: labelText,
                labelStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.normal,
                  color: AppColors.disabledColor,
                ),
                errorStyle: TextStyle(
                  letterSpacing: 1,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.normal,
                  color: Colors.red,
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.disabledColor,
                    width: 1.5,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(2.0.r),
                  borderSide: const BorderSide(
                    color: AppColors.borderColor,
                    width: 1.5,
                  ),
                ),
              ),
              style: TextStyle(
                letterSpacing: 1.5,
                fontSize: 14.sp,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.normal,
                color: AppColors.disabledColor,
              ),
              onChanged: (value) {
                description = value;
              },
            ),
          ),
          UIHelper.horizontalSpaceMedium,
          Expanded(
            child: Row(
              children: [
                InkWell(
                  child: Icon(
                    Icons.save,
                    size: 40.sp,
                  ),
                  onTap: () async {
                    Map e = _items
                        .firstWhere((element) => element['is_default'] == 1);
                    log(e.toString());

                    await postProductPriceRXobj.postProductPriceData(name,
                        price, isDefault ? 1 : 0, description, restaurantfoodId,
                        optionId: optionId);
                    if (e != null) {
                      await postProductPriceRXobj.postProductPriceData(
                          e['name'],
                          e['price'],
                          0,
                          e['description'],
                          e['restaurant_food_id'],
                          optionId: e['id']);
                    }
                    dataLoading();
                  },
                ),
                if (!isDefault)
                  InkWell(
                    child: Icon(
                      Icons.delete,
                      size: 40.sp,
                    ),
                    onTap: () async {
                      await deleteProductOptionPriceRxobj
                          .deleteProductOptionPrice(optionId.toString());
                      dataLoading();
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  mobileFormCardWidget(
    int optionId,
    String name,
    String price,
    bool isDefault,
    String description,
    TextEditingController nameController,
    TextEditingController priceController,
    TextEditingController descriptionController,
  ) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Option Name",
                    style: TextFontStyle.tableHeader,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left),
                Spacer(),
                SizedBox(
                  width: .65.sw,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 20),
                      hintText: 'Insert Name',
                      hintStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: AppColors.disabledColor,
                      ),
                      //labelText: labelText,
                      labelStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w100,
                        fontStyle: FontStyle.normal,
                        color: AppColors.disabledColor,
                      ),
                      errorStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w100,
                        fontStyle: FontStyle.normal,
                        color: Colors.red,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.disabledColor,
                          width: 1.5,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w100,
                      fontStyle: FontStyle.normal,
                      color: AppColors.disabledColor,
                    ),
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Text("Price",
                    style: TextFontStyle.tableHeader,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left),
                Spacer(),
                SizedBox(
                  width: .65.sw,
                  child: TextFormField(
                    controller: priceController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 20),
                      hintText: 'Price',
                      hintStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: AppColors.disabledColor,
                      ),
                      //labelText: labelText,
                      labelStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w100,
                        fontStyle: FontStyle.normal,
                        color: AppColors.disabledColor,
                      ),
                      errorStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w100,
                        fontStyle: FontStyle.normal,
                        color: Colors.red,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.disabledColor,
                          width: 1.5,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w100,
                      fontStyle: FontStyle.normal,
                      color: AppColors.disabledColor,
                    ),
                    onChanged: (value) {
                      price = value;
                    },
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Text("Is Default?",
                    style: TextFontStyle.tableHeader,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left),
                UIHelper.horizontalSpaceSmall,
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    activeColor: AppColors.primaryColor,
                    value: isDefault,
                    onChanged: (value) async {
                      isDefault = value!;
                      Map e = _items
                          .firstWhere((element) => element['is_default'] == 1);
                      log(e.toString());

                      await postProductPriceRXobj.postProductPriceData(name,
                          price, value ? 1 : 0, description, restaurantfoodId,
                          optionId: optionId);
                      // onSaveData(name, price, value!, description,
                      //     restaurantfoodId, optionId);
                      if (e != null) {
                        await postProductPriceRXobj.postProductPriceData(
                            e['name'],
                            e['price'],
                            0,
                            e['description'],
                            e['restaurant_food_id'],
                            optionId: e['id']);
                      }
                      dataLoading();
                    },
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Text("Description",
                    style: TextFontStyle.tableHeader,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left),
                Spacer(),
                SizedBox(
                  width: .65.sw,
                  child: TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 20),
                      hintText: 'Description',
                      hintStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: AppColors.disabledColor,
                      ),
                      //labelText: labelText,
                      labelStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w100,
                        fontStyle: FontStyle.normal,
                        color: AppColors.disabledColor,
                      ),
                      errorStyle: TextStyle(
                        letterSpacing: 1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w100,
                        fontStyle: FontStyle.normal,
                        color: Colors.red,
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.disabledColor,
                          width: 1.5,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 1.5,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0.r),
                        borderSide: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1.5,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w100,
                      fontStyle: FontStyle.normal,
                      color: AppColors.disabledColor,
                    ),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Actions', style: TextFontStyle.mobileBold),
                Spacer(),
                InkWell(
                  child: Icon(
                    Icons.save,
                    size: 40.sp,
                  ),
                  onTap: () async {
                    Map e = _items
                        .firstWhere((element) => element['is_default'] == 1);
                    log(e.toString());

                    await postProductPriceRXobj.postProductPriceData(name,
                        price, isDefault ? 1 : 0, description, restaurantfoodId,
                        optionId: optionId);
                    if (e != null) {
                      await postProductPriceRXobj.postProductPriceData(
                          e['name'],
                          e['price'],
                          0,
                          e['description'],
                          e['restaurant_food_id'],
                          optionId: e['id']);
                    }
                    dataLoading();
                  },
                ),
                UIHelper.horizontalSpaceMedium,
                if (!isDefault)
                  InkWell(
                    child: Icon(
                      Icons.delete,
                      size: 40.sp,
                    ),
                    onTap: () async {
                      await deleteProductOptionPriceRxobj
                          .deleteProductOptionPrice(optionId.toString());
                      dataLoading();
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
