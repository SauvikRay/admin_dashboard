// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/table_card.dart';
import '/helpers/di.dart';
import '/networks/api_acess.dart';
import '/networks/rx_orders/rx.dart';

import '../constants/app_color.dart';
import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../helpers/all_routes.dart';
import '../helpers/helper.dart';
import '../helpers/navigation_service.dart';
import '../helpers/table_model/order_type.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/custome_table.dart';
import '../widgets/delete_dilouge_widget.dart';
import '../widgets/inkwell_button.dart';
import '../widgets/order_status.dart';
import '../widgets/plus_button_dilouge_widget.dart';
import '../widgets/popup_number_widget.dart';
import '../widgets/radius_dilouge_widget.dart';

class TodasAsCategories extends StatefulWidget {
  const TodasAsCategories({Key? key}) : super(key: key);

  @override
  State<TodasAsCategories> createState() => _TodasAsCategoriesState();
}

class _TodasAsCategoriesState extends State<TodasAsCategories> {
  OrderType order = locator<OrderType>();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController _recordSearchController = TextEditingController();
  List<dynamic> items = [];
  int totalRec = 0;
  int startRec = 0;
  int endRec = 0;
  List<dynamic> serachList = [];
  int _page = 1;

  @override
  void initState() {
    numberController.text = '10';
    _recordSearchController.addListener(onSearchTextChanged);
    getOrdersRXobj.getOrdersData.listen((value) {
      setState(() {
        items = value['data']['orders']['data'];
        totalRec = value['data']['total'];
        startRec = value['data']['start'];
        endRec = value['data']['end'];
      });
    });

    numberController.addListener(
      () {
        int record = int.parse(numberController.value.text);
        getOrdersRXobj.fetchOrderData(order.getorderStaus,
            record: record, page: _page);
      },
    );

    getOrdersRXobj.getOrdersData.first.then((value) {
      setState(() {
        items = value['data']['orders']['data'];
        serachList = value['data']['orders']['data'];
      });
    });
    super.initState();
  }

  onSearchTextChanged() async {
    String text = _recordSearchController.value.text;

    List<dynamic> newItems = [];

    if (text.isNotEmpty) {
      for (var detail in serachList) {
        if (detail['order_code'].contains(text) ||
            detail['total_price'].contains(text) ||
            detail['change'].contains(text) ||
            detail['admin_income'].contains(text) ||
            detail['created_at'].contains(text)) newItems.add(detail);
      }
    }
    if (newItems.isNotEmpty) {
      setState(() {
        items = newItems;
      });
    }

    if (text.isEmpty) {
      setState(() {
        items = serachList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
            vertical: UIHelper.kDefaulutPadding()),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pendente Lista de Encomendas',
                style: TextFontStyle.headline1BoldStyle,
                textAlign: TextAlign.left,
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                'Aqui pode ver a lista de lojas',
                style: TextFontStyle.headline1RegularStyle,
              ),
              UIHelper.verticalSpaceSmall,
              //Search Bar
              Row(
                children: [
                  //DropDown PopUp
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                    ),
                    height: 30.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: AppColors.borderColor, width: 0.5)),
                    child: PopupNumberWidget(
                      number: numberController,
                    ),
                  ),
                  UIHelper.horizontalSpaceSmall,
                  Text(
                    'Entries',
                    style: TextFontStyle.headline2RegularStyle,
                  ),
                  const Spacer(),
                  Container(
                    height: 35.h,
                    width: 150.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                            color: AppColors.borderColor, width: 0.5.h)),
                    child: TextFormField(
                      controller: _recordSearchController,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              (ScreenUtil().screenWidth < 600)
                  ? ListView.separated(
                      separatorBuilder: (_, index) =>
                          UIHelper.verticalSpaceMedium,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (_, index) {
                        return DataCard(
                          items: items,
                          numberController: numberController,
                          page: _page,
                          index: index,
                        );
                      })
                  : CustomTable(
                      items: items,
                      numberController: numberController,
                      page: _page),

              UIHelper.verticalSpaceMedium,
              UIHelper.customDivider(),
              UIHelper.verticalSpaceMedium,
              //No data
              if (items.isEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No data available in table',
                      style: TextFontStyle.subtitle1RegularStyle,
                    )
                  ],
                ),
              UIHelper.verticalSpaceMedium,

              Row(
                children: [
                  Text(
                    'Showing $startRec to $endRec of $totalRec entries',
                    style: TextFontStyle.subtitle1BoldStyle,
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.disabledColor, width: 0.5),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: IntrinsicHeight(
                      child: Row(children: [
                        InkWell(
                          child: Icon(
                            Icons.arrow_left_sharp,
                            size: 30.sp,
                            color: AppColors.primaryColor,
                          ),
                          onTap: () {
                            if (_page >= 2) {
                              setState(() {
                                _page -= 1;
                                int record =
                                    int.parse(numberController.value.text);
                                getOrdersRXobj.fetchOrderData(
                                    order.getorderStaus,
                                    record: record,
                                    page: _page);
                              });
                            }
                          },
                        ),
                        const VerticalDivider(
                          color: AppColors.disabledColor,
                          thickness: 1,
                        ),
                        Text(
                          _page.toString(),
                          style: TextFontStyle.subtitle1RegularStyle,
                        ),
                        const VerticalDivider(
                          color: AppColors.disabledColor,
                          thickness: 1,
                        ),
                        InkWell(
                          child: Icon(
                            Icons.arrow_right_sharp,
                            size: 30.sp,
                            color: AppColors.primaryColor,
                          ),
                          onTap: () {
                            int record = int.parse(numberController.value.text);
                            if (items.length == record) {
                              setState(() {
                                _page += 1;
                                getOrdersRXobj.fetchOrderData(
                                    order.getorderStaus,
                                    record: record,
                                    page: _page);
                              });
                            } else {
                              const snackBar = SnackBar(
                                content: Text('No more records to show'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
