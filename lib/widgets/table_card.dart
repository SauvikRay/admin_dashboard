// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../constants/app_color.dart';
import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../helpers/all_routes.dart';
import '../helpers/di.dart';
import '../helpers/helper.dart';
import '../helpers/navigation_service.dart';
import '../helpers/table_model/order_id.dart';
import '../networks/api_acess.dart';
import '../screens/produtos_screen.dart';
import 'order_status.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    Key? key,
    required this.items,
    required this.numberController,
    required int page,
    required this.index,
  })  : _page = page,
        super(key: key);

  final List items;
  final TextEditingController numberController;
  final int _page;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
      elevation: 3.0,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
        child: Column(
          children: [
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(items[index]['order_code'], // '20220801491',
                    overflow: TextOverflow.ellipsis,
                    style: TextFontStyle.mobileBold),
                UIHelper.horizontalSpaceSmall,
                Text(
                    dateFormat(items[index]['created_at']
                        .toString()), //'01-08-2022 07:00:19',
                    overflow: TextOverflow.fade,
                    style: TextFontStyle.mobileBold),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item Total Price : ', style: TextFontStyle.mobileNormal),
                Text('${items[index]['total_price']}€',
                    style: TextFontStyle.mobileNormal),
              ],
            ),
            UIHelper.verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Income : ', style: TextFontStyle.mobileSemiBold),
                Text('${items[index]['admin_income']}€',
                    style: TextFontStyle.mobileNormal),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Text('Pickup and Delivery Info', style: TextFontStyle.mobileBold),
            UIHelper.verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.phone,
                          size: 15,
                          color: AppColors.headLine1Color,
                        ),
                        UIHelper.horizontalSpace(10.h),
                        (items[index]['phone'].toString() == 'null')
                            ? Text('N/A', style: TextFontStyle.mobileNormal)
                            : Text(items[index]['phone'].toString(),
                                style: TextFontStyle.mobileNormal)
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.bagShopping,
                          size: 15,
                          color: AppColors.headLine1Color,
                        ),
                        UIHelper.horizontalSpace(10.h),
                        Text(items[index]['pickup_date_time'],
                            style: TextFontStyle.mobileNormal),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.motorcycle,
                          size: 15,
                          color: AppColors.penIconColor,
                        ),
                        UIHelper.horizontalSpace(10.h),
                        Text(items[index]['expected_delivery_time'],
                            style: TextFontStyle.mobileNormal),
                      ],
                    )
                  ],
                ),
                Spacer(),
                InkWell(
                  child: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.penIconColor,
                    size: 25,
                  ),
                  onTap: () async {
                    await getOrderDetailsRXobj
                        .fetchOrderDetailsData(items[index]['order_code']);
                    String id = items[index]['order_code'].toString();
                    locator<OrderId>().setOrderId = id;
                    NavigationService.navigateTo(Routes.orderDetailScreen);
                  },
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Text('Order Status', style: TextFontStyle.mobileBold),
            UIHelper.verticalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OrderStatus(
                  title: "Order",
                  status: "${items[index]['status_text']}",
                  statusType: StatusType.order,
                  statuscode: "${items[index]['status']}",
                ),
                UIHelper.verticalSpace(5),
                OrderStatus(
                  title: "Delivery",
                  status: "${items[index]['delivery_status_text']}",
                  statuscode: "${items[index]['delivery_status']}",
                  statusType: StatusType.delivery,
                ),
                UIHelper.verticalSpace(2),
                const OrderStatus(
                  status: "Invoiced",
                  statusType: StatusType.order,
                  statuscode: OrderStatusNo.kCANCELLED,
                ),
                UIHelper.verticalSpace(2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Status : ",
                      style: TextFontStyle.mobileSemiBold,
                    ),
                    const Spacer(),
                    if (items[index]['status'] == 10)
                      IconButton(
                        iconSize: 20.r,
                        icon: FaIcon(
                            color: Color(0xFF21a5c2),
                            FontAwesomeIcons.circleNotch),
                        onPressed: () {
                          int record = int.parse(numberController.value.text);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Expanded(
                                    child: deleteButtonDialouge(
                                      context,
                                      orderno: items[index]['order_code'],
                                      stausNo: 20,
                                      page: _page,
                                      record: record,
                                    ),
                                  ));
                        },
                      ),
                    if (items[index]['status'] == 10 ||
                        items[index]['status'] == 20)
                      IconButton(
                        iconSize: 25.r,
                        icon: FaIcon(
                            color: Color(0xFF5ad092), FontAwesomeIcons.check),
                        onPressed: () {
                          int record = int.parse(numberController.value.text);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => Expanded(
                                    child: deleteButtonDialouge(
                                      context,
                                      orderno: items[index]['order_code'],
                                      stausNo: 21,
                                      page: _page,
                                      record: record,
                                    ),
                                  ));
                        },
                      ),
                    if (items[index]['status'] != 10 &&
                        items[index]['status'] != 20)
                      const Text(
                        "N/A",
                      )
                  ],
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
          ],
        ),
      ),
    );
  }
}




  // Card(
                    //   margin: EdgeInsets.symmetric(
                    //       horizontal: 10.w, vertical: 10.h),
                    //   elevation: 3.0,
                    //   child: Container(
                    //     padding: EdgeInsets.symmetric(
                    //         horizontal: 20.w, vertical: 5.h),
                    //     child: Column(
                    //       children: [
                    //         UIHelper.verticalSpaceMedium,
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           // crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //                 items[index]
                    //                     ['order_code'], // '20220801491',
                    //                 overflow: TextOverflow.ellipsis,
                    //                 style: TextFontStyle.mobileBold),
                    //             Text(
                    //                 dateFormat(items[index]['created_at']
                    //                     .toString()), //'01-08-2022 07:00:19',
                    //                 overflow: TextOverflow.ellipsis,
                    //                 style: TextFontStyle.mobileBold),
                    //           ],
                    //         ),
                    //         UIHelper.verticalSpaceMedium,
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text('Item Total Price : ',
                    //                 style: TextFontStyle.mobileNormal),
                    //             Text('${items[index]['total_price']}€',
                    //                 style: TextFontStyle.mobileNormal),
                    //           ],
                    //         ),
                    //         UIHelper.verticalSpaceSmall,
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text('Income : ',
                    //                 style: TextFontStyle.mobileSemiBold),
                    //             Text('${items[index]['admin_income']}€',
                    //                 style: TextFontStyle.mobileNormal),
                    //           ],
                    //         ),
                    //         UIHelper.verticalSpaceMedium,
                    //         Text('Pickup and Delivery Info',
                    //             style: TextFontStyle.mobileBold),
                    //         UIHelper.verticalSpaceSmall,
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     Icon(
                    //                       FontAwesomeIcons.phone,
                    //                       size: 15,
                    //                       color: AppColors.headLine1Color,
                    //                     ),
                    //                     UIHelper.horizontalSpace(10.h),
                    //                     Text(items[index]['phone'].toString(),
                    //                         style: TextFontStyle.mobileNormal)
                    //                   ],
                    //                 ),
                    //                 UIHelper.verticalSpaceSmall,
                    //                 Row(
                    //                   children: [
                    //                     Icon(
                    //                       FontAwesomeIcons.bagShopping,
                    //                       size: 15,
                    //                       color: AppColors.headLine1Color,
                    //                     ),
                    //                     UIHelper.horizontalSpace(10.h),
                    //                     Text(items[index]['pickup_date_time'],
                    //                         style: TextFontStyle.mobileNormal),
                    //                   ],
                    //                 ),
                    //                 UIHelper.verticalSpaceSmall,
                    //                 Row(
                    //                   // mainAxisAlignment: MainAxisAlignment.center,
                    //                   children: [
                    //                     Icon(
                    //                       FontAwesomeIcons.motorcycle,
                    //                       size: 15,
                    //                       color: AppColors.penIconColor,
                    //                     ),
                    //                     UIHelper.horizontalSpace(10.h),
                    //                     Text(
                    //                         items[index]
                    //                             ['expected_delivery_time'],
                    //                         style: TextFontStyle.mobileNormal),
                    //                   ],
                    //                 )
                    //               ],
                    //             ),
                    //             Spacer(),
                    //             InkWell(
                    //               child: Icon(
                    //                 Icons.remove_red_eye_outlined,
                    //                 color: AppColors.penIconColor,
                    //                 size: 25,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //         UIHelper.verticalSpaceMedium,
                    //         Text('Order Status',
                    //             style: TextFontStyle.mobileBold),
                    //         UIHelper.verticalSpaceSmall,
                    //         Column(
                    //           crossAxisAlignment: CrossAxisAlignment.end,
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             OrderStatus(
                    //               title: "Order",
                    //               status: "${items[index]['status_text']}",
                    //               statusType: StatusType.order,
                    //               statuscode: "${items[index]['status']}",
                    //             ),
                    //             UIHelper.verticalSpace(5),
                    //             OrderStatus(
                    //               title: "Delivery",
                    //               status:
                    //                   "${items[index]['delivery_status_text']}",
                    //               statuscode:
                    //                   "${items[index]['delivery_status']}",
                    //               statusType: StatusType.delivery,
                    //             ),
                    //             UIHelper.verticalSpace(2),
                    //             const OrderStatus(
                    //               status: "Invoiced",
                    //               statusType: StatusType.order,
                    //               statuscode: OrderStatusNo.kCANCELLED,
                    //             ),
                    //             UIHelper.verticalSpace(2),
                    //             Row(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               //mainAxisAlignment: MainAxisAlignment.end,
                    //               children: [
                    //                 Text(
                    //                   "Status : ",
                    //                   style: TextFontStyle.mobileSemiBold,
                    //                 ),
                    //                 Spacer(),
                    //                 if (items[index]['status'] == 10)
                    //                   IconButton(
                    //                     iconSize: 20.r,
                    //                     icon: FaIcon(
                    //                         color: Color(0xFF21a5c2),
                    //                         FontAwesomeIcons.circleNotch),
                    //                     onPressed: () {
                    //                       int record = int.parse(
                    //                           numberController.value.text);
                    //                       showDialog(
                    //                           context: context,
                    //                           builder: (BuildContext context) =>
                    //                               Expanded(
                    //                                 child: deleteButtonDialouge(
                    //                                   context,
                    //                                   orderno: items[index]
                    //                                       ['order_code'],
                    //                                   stausNo: 20,
                    //                                   page: _page,
                    //                                   record: record,
                    //                                 ),
                    //                               ));
                    //                     },
                    //                   ),
                    //                 if (items[index]['status'] == 10 ||
                    //                     items[index]['status'] == 20)
                    //                   IconButton(
                    //                     iconSize: 25.r,
                    //                     icon: FaIcon(
                    //                         color: Color(0xFF5ad092),
                    //                         FontAwesomeIcons.check),
                    //                     onPressed: () {
                    //                       int record = int.parse(
                    //                           numberController.value.text);
                    //                       showDialog(
                    //                           context: context,
                    //                           builder: (BuildContext context) =>
                    //                               Expanded(
                    //                                 child: deleteButtonDialouge(
                    //                                   context,
                    //                                   orderno: items[index]
                    //                                       ['order_code'],
                    //                                   stausNo: 21,
                    //                                   page: _page,
                    //                                   record: record,
                    //                                 ),
                    //                               ));
                    //                     },
                    //                   ),
                    //                 if (items[index]['status'] != 10 &&
                    //                     items[index]['status'] != 20)
                    //                   const Text(
                    //                     "N/A",
                    //                   )
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //         UIHelper.verticalSpaceLarge,
                    //       ],
                    //     ),
                    //   ),
                    // );
                  
