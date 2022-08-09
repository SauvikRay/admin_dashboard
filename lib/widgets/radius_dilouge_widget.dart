import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/helpers/navigation_service.dart';

import '../constants/app_color.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../networks/api_acess.dart';
import 'custom_button.dart';
import 'custome_textfield.dart';

Widget radiusDialouge(BuildContext context) {
  TextEditingController radiusController = TextEditingController();
  return Dialog(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),

      // height: 400.h,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 400.w),
        child: Column(
          children: [
            Text(
              'Definir raio de clientes',
              style: TextFontStyle.headline1BoldStyle
                  .copyWith(color: Colors.black),
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Text(
                  'Intervalo de Raio (km)',
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
              child: StreamBuilder(
                stream: getCustomerRangeRXobj.getCustomerRangeResData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Map data = snapshot.data as Map;
                    radiusController.text = data['data']['shopCustomerRange'];
                    return CustomNumberFormField(
                      inputType: TextInputType.number,
                      labelText: '',
                      textEditingController: radiusController,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            UIHelper.verticalSpaceMedium,
            //Gravar Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customeButton(
                    name: 'Gravar',
                    onCallBack: () async {
                      Navigator.pop(context);
                      await postShopCustomerRangeRXobj.postShopCustomerRange(
                          range: radiusController.value.text);
                      await getCustomerRangeRXobj.fetchCustomerRageData();
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
                      Navigator.pop(context);
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
