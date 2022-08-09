import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import '/helpers/all_routes.dart';
import '/helpers/navigation_service.dart';
import '/networks/api_acess.dart';
import '/widgets/loading_indicators.dart';

import '../constants/app_color.dart';
import '../constants/app_constants.dart';

import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../helpers/di.dart';
import '../helpers/table_model/order_type.dart';
import '../screens/test_navigation_screen.dart';

class OptionButtonDialoge extends StatefulWidget {
  const OptionButtonDialoge({Key? key}) : super(key: key);

  @override
  State<OptionButtonDialoge> createState() => _OptionButtonDialogeState();
}

class _OptionButtonDialogeState extends State<OptionButtonDialoge> {
  String string = 'A';
  int colorIndex = 0;
  final storage = GetStorage();
  @override
  Widget build(BuildContext context) {
    var ScreenSize = MediaQuery.of(context).size;
    print('height: ${ScreenSize.height}');
    print('width:${ScreenSize.width}');
    return Padding(
      padding: EdgeInsets.only(top: 100.h),
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)),
        alignment: Alignment.topRight,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: ConstrainedBox(
          constraints: (ScreenSize.width <= 600)
              ? BoxConstraints(maxWidth: .80.sw)
              : BoxConstraints(maxWidth: .50.sw),
          child: Container(
            // color: Colors.green,
            margin: EdgeInsets.only(top: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
            // width: 10.w,
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: boddy(context, string),
                ),
                // UIHelper.horizontalSpaceMedium,
                const VerticalDivider(
                  color: AppColors.disabledColor,
                  thickness: 0.5,
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //First Button
                      InkWell(
                        onTap: () {
                          setState(() {
                            string = 'A';
                            colorIndex = 0;
                          });
                        },
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: colorIndex == 0
                                ? AppColors.primaryColor
                                : AppColors.disabledColor,
                          ),
                          child: SvgPicture.asset(
                            AssetIcons.shop,
                            color: AppColors.white,
                          ),
                        ),
                      ),

                      UIHelper.verticalSpaceLarge,
                      //Second Button
                      InkWell(
                        onTap: () {
                          setState(() {
                            String shopID = storage.read(kKeyShopID) ?? '';
                            if (shopID != '') {
                              string = 'B';
                              colorIndex = 1;
                            }
                          });
                        },
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: colorIndex == 1
                                ? AppColors.primaryColor
                                : AppColors.disabledColor,
                          ),
                          child: SvgPicture.asset(
                            AssetIcons.box,
                            color: AppColors.white,
                          ),
                        ),
                      ),

                      UIHelper.verticalSpaceLarge,
                      //Thired Button
                      InkWell(
                        onTap: () {
                          String shopID = storage.read(kKeyShopID) ?? '';
                          setState(() {
                            if (shopID != '') {
                              string = 'C';
                              colorIndex = 2;
                            }
                          });
                        },
                        child: Container(
                          height: 50.h,
                          width: 50.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.r),
                            color: colorIndex == 2
                                ? AppColors.primaryColor
                                : AppColors.disabledColor,
                          ),
                          child: SvgPicture.asset(
                            AssetIcons.orderslist,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget boddy(BuildContext context, string) {
  switch (string) {
    case 'A':
      return loja(context);
    case 'B':
      return product(context);
    case 'C':
      return orders(context);
    default:
      return loja(context);
  }
}

Widget loja(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AssetIcons.shop,
              height: 15.h,
              width: 15.h,
            ),
            Expanded(
              child: Text('Loja',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.headline1RegularStyle.copyWith(
                      letterSpacing: 2,
                      wordSpacing: 1,
                      color: AppColors.primaryColor)),
            ),
            const Spacer(),
          ],
        ),
      ),
      UIHelper.verticalSpaceMedium,
      UIHelper.customDivider(),
      UIHelper.verticalSpaceMedium,
      //For change Password
      InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AssetIcons.shop,
                height: 15.h,
                width: 15.h,
              ),
              Expanded(
                child: Text('Lojas',
                    textAlign: TextAlign.center,
                    style: TextFontStyle.headline1RegularStyle.copyWith(
                        letterSpacing: 2,
                        wordSpacing: 1,
                        color: AppColors.primaryColor)),
              ),
              const Spacer(),
            ],
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          NavigationService.navigateTo(Routes.lojas);
        },
      ),
    ],
  );
}

Widget product(BuildContext context) {
  return Column(
    children: [
      //Produtos
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AssetIcons.box,
              height: 15.h,
              width: 15.h,
              color: Colors.black,
            ),
            UIHelper.horizontalSpaceSmall,
            Text('Produtos',
                textAlign: TextAlign.center,
                style: TextFontStyle.headline1RegularStyle.copyWith(
                    letterSpacing: 2, wordSpacing: 1, color: Colors.black)),
            const Spacer(),
          ],
        ),
      ),
      UIHelper.verticalSpaceMedium,
      UIHelper.customDivider(),
      UIHelper.verticalSpaceMedium,
      //Categorias
      InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AssetIcons.box,
                height: 15.h,
                width: 15.h,
                color: Colors.black,
              ),
              UIHelper.horizontalSpaceSmall,
              Text('Categorias',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.headline2RegularStyle.copyWith(
                    letterSpacing: 2,
                    wordSpacing: 1,
                    color: Colors.black,
                  )),
              const Spacer(),
            ],
          ),
        ),
        onTap: () {
          // Navigator.pop(context);
          NavigationService.navigateTo(Routes.categories);
        },
      ),
      //Produtos
      UIHelper.verticalSpaceMedium,
      InkWell(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AssetIcons.box,
                height: 15.h,
                width: 15.h,
                color: Colors.black,
              ),
              UIHelper.horizontalSpaceSmall,
              Text('Produtos',
                  textAlign: TextAlign.center,
                  style: TextFontStyle.headline2RegularStyle.copyWith(
                    letterSpacing: 2,
                    wordSpacing: 1,
                    color: Colors.black,
                  )),
              const Spacer(),
            ],
          ),
        ),
        onTap: () {
          NavigationService.navigateTo(Routes.produtos);
        },
      ),
    ],
  );
}

Widget orders(BuildContext context) {
  OrderType order = locator<OrderType>();
  return StreamBuilder(
      stream: getOrderCountRXobj.getOrderCountData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map data = snapshot.data as Map;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AssetIcons.orderslist,
                      height: 15.h,
                      width: 15.h,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Text('Encomenda(${data['data']['allOrder']})',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline2RegularStyle.copyWith(
                              letterSpacing: 2,
                              wordSpacing: 1,
                              color: AppColors.primaryColor)),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpaceMedium,
              UIHelper.customDivider(),
              UIHelper.verticalSpaceMedium,
              //Todas as encomendas (5)
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.orderslist,
                        height: 15.h,
                        width: 15.h,
                        color: Colors.black,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      SizedBox(
                        width: (ScreenUtil().screenWidth < 600) ? 145.w : 215.w,
                        child: Text(
                            'Todas as encomendas (${data['data']['allOrder']})',
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.fade,
                            style: TextFontStyle.headline2RegularStyle.copyWith(
                                letterSpacing: 2,
                                wordSpacing: 1,
                                color: Colors.black)),
                      ),
                    ],
                  ),
                ),
                onTap: () async {
                  showDialog(
                    context: NavigationService.context,
                    builder: (context) =>
                        loadingIndicatorCircle(context: context),
                  );
                  await getOrdersRXobj.fetchOrderData(OrderStatusNo.kALL);
                  order.setorderStaus = OrderStatusNo.kALL;
                  NavigationService.navigateTo(Routes.todasAsCategories);
                },
              ),
              UIHelper.verticalSpaceSmall,
              //Pendente (0)
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.orderslist,
                        height: 15.h,
                        width: 15.h,
                        color: Colors.black,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Text('Pendente (${data['data']['pendingOrder']})',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline2RegularStyle.copyWith(
                              letterSpacing: 2,
                              wordSpacing: 1,
                              color: Colors.black)),
                    ],
                  ),
                ),
                onTap: () async {
                  showDialog(
                    context: NavigationService.context,
                    builder: (context) =>
                        loadingIndicatorCircle(context: context),
                  );
                  await getOrdersRXobj.fetchOrderData(OrderStatusNo.kPENDING);
                  order.setorderStaus = OrderStatusNo.kPENDING;
                  NavigationService.navigateTo(Routes.todasAsCategories);
                },
              ),
              UIHelper.verticalSpaceSmall,
              //Aceite (0)
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.orderslist,
                        height: 15.h,
                        width: 15.h,
                        color: Colors.black,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Text('Aceite (${data['data']['acceptedOrder']})',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline2RegularStyle.copyWith(
                              letterSpacing: 2,
                              wordSpacing: 1,
                              color: Colors.black)),
                    ],
                  ),
                ),
                onTap: () async {
                  showDialog(
                    context: NavigationService.context,
                    builder: (context) =>
                        loadingIndicatorCircle(context: context),
                  );
                  await getOrdersRXobj.fetchOrderData(OrderStatusNo.kACCEPTED);
                  order.setorderStaus = OrderStatusNo.kACCEPTED;
                  NavigationService.navigateTo(Routes.todasAsCategories);
                },
              ),
              UIHelper.verticalSpaceSmall,
              //Recolhido (0)
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.orderslist,
                        height: 15.h,
                        width: 15.h,
                        color: Colors.black,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Text('Recolhido (${data['data']['pickedOrder']})',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline2RegularStyle.copyWith(
                              letterSpacing: 2,
                              wordSpacing: 1,
                              color: Colors.black)),
                    ],
                  ),
                ),
                onTap: () async {
                  showDialog(
                    context: NavigationService.context,
                    builder: (context) =>
                        loadingIndicatorCircle(context: context),
                  );
                  await getOrdersRXobj
                      .fetchOrderData(OrderStatusNo.kFOODPICKED);
                  order.setorderStaus = OrderStatusNo.kFOODPICKED;
                  NavigationService.navigateTo(Routes.todasAsCategories);
                },
              ),
              UIHelper.verticalSpaceSmall,
              //Entregue (0)
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.orderslist,
                        height: 15.h,
                        width: 15.h,
                        color: Colors.black,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Text('Entregue (${data['data']['deliveredOrder']})',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline2RegularStyle.copyWith(
                              letterSpacing: 2,
                              wordSpacing: 1,
                              color: Colors.black)),
                    ],
                  ),
                ),
                onTap: () async {
                  showDialog(
                    context: NavigationService.context,
                    builder: (context) =>
                        loadingIndicatorCircle(context: context),
                  );
                  await getOrdersRXobj
                      .fetchOrderData(OrderStatusNo.kFOODDELIVERED);
                  order.setorderStaus = OrderStatusNo.kFOODDELIVERED;
                  NavigationService.navigateTo(Routes.todasAsCategories);
                },
              ),
              //Cancelado (0)
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.orderslist,
                        height: 15.h,
                        width: 15.h,
                        color: Colors.black,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Text('Cancelado (${data['data']['cancelledOrder']})',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline2RegularStyle.copyWith(
                              letterSpacing: 2,
                              wordSpacing: 1,
                              color: Colors.black)),
                    ],
                  ),
                ),
                onTap: () async {
                  showDialog(
                    context: NavigationService.context,
                    builder: (context) =>
                        loadingIndicatorCircle(context: context),
                  );
                  await getOrdersRXobj.fetchOrderData(OrderStatusNo.kCANCELLED);
                  order.setorderStaus = OrderStatusNo.kCANCELLED;
                  NavigationService.navigateTo(Routes.todasAsCategories);
                },
              ),
              UIHelper.verticalSpaceSmall,
              //Rejeitado (0)
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.orderslist,
                        height: 15.h,
                        width: 15.h,
                        color: Colors.black,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Text('Rejeitado (${data['data']['rejectedOrder']})',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline2RegularStyle.copyWith(
                              letterSpacing: 2,
                              wordSpacing: 1,
                              color: Colors.black)),
                    ],
                  ),
                ),
                onTap: () async {
                  showDialog(
                    context: NavigationService.context,
                    builder: (context) =>
                        loadingIndicatorCircle(context: context),
                  );
                  await getOrdersRXobj
                      .fetchOrderData(OrderStatusNo.kREJECTEDBYSHOP);
                  order.setorderStaus = OrderStatusNo.kREJECTEDBYSHOP;
                  NavigationService.navigateTo(Routes.todasAsCategories);
                },
              ),
              UIHelper.verticalSpaceSmall,
              //Falhado(0)
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        AssetIcons.orderslist,
                        height: 15.h,
                        width: 15.h,
                        color: Colors.black,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Text('Falhado(${data['data']['failedOrder']})',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headline2RegularStyle.copyWith(
                              letterSpacing: 2,
                              wordSpacing: 1,
                              color: Colors.black)),
                    ],
                  ),
                ),
                onTap: () async {
                  showDialog(
                    context: NavigationService.context,
                    builder: (context) =>
                        loadingIndicatorCircle(context: context),
                  );
                  await getOrdersRXobj.fetchOrderData(OrderStatusNo.kFAILED);
                  order.setorderStaus = OrderStatusNo.kFAILED;
                  NavigationService.navigateTo(Routes.todasAsCategories);
                },
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: loadingIndicatorCircle(context: context),
          );
        } else {
          return SizedBox.shrink();
        }
      });
}
