import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '/helpers/navigation_service.dart';

import '../constants/app_color.dart';
import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../helpers/di.dart';
import '../helpers/table_model/order_type.dart';
import '../networks/api_acess.dart';
import 'custom_button.dart';
import 'custome_textfield.dart';

Widget deleteButtonDialouge(BuildContext context,
    {String? orderno, int? stausNo, int? record, int? page}) {
  OrderType order = locator<OrderType>();

  return Dialog(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),

      // height: 400.h,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: .27.sh, maxWidth: .38.sw),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(AssetIcons.i),
            Text(
              'Are you sure?',
              style: TextFontStyle.headline1BoldStyle
                  .copyWith(color: Colors.black),
            ),
            UIHelper.verticalSpaceMedium,
            Text(
              'You won\'t be able to revert this! ?',
              style: TextFontStyle.headline2BoldStyle,
            ),
            UIHelper.verticalSpaceMedium,

            //Gravar Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customeButton(
                    name: 'No',
                    onCallBack: () {
                      NavigationService.goBack;
                    },
                    height: 30.h,
                    minWidth: 130.w,
                    borderRadius: 8.r,
                    color: AppColors.primaryColor,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
                UIHelper.horizontalSpaceSmall,
                //Cancelar
                customeButton(
                    name: 'Yes',
                    onCallBack: () async {
                      await deleteShopRXobj.deleteShopData();
                      await getShopListRXobj.fetchShopListData();
                      NavigationService.goBack;
                    },
                    height: 30.h,
                    minWidth: 130.w,
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
