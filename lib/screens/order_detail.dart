import 'dart:developer';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import '/constants/app_constants.dart';
import '/constants/text_font_style.dart';
import '/helpers/di.dart';
import '/helpers/table_model/order_id.dart';
import '/widgets/loading_indicators.dart';

import '../constants/app_color.dart';
import '../constants/ui_helpers.dart';
import '../networks/api_acess.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/tracking_widgets.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  String orderStatusInfo = '';
  String deliveryStatusInfo = '';
  bool lastVal = false;
  List<dynamic> items = [];
  @override
  void initState() {
    // TODO: implement initState
    loadOrderData();

    super.initState();
  }

  loadOrderData() async {
    await getOrderDetailsRXobj
        .fetchOrderDetailsData(locator<OrderId>().getOrderId); //'20211006109'
    getOrderDetailsRXobj.getOrderDetailsData;
  }

  //GoogleMap

  MapType mapType = MapType.normal;
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> createMarker(double lat, double long, String markerId) {
    return {
      Marker(
          markerId: MarkerId(markerId),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: markerId),
          rotation: 0),
    };
  }

  final Set<Marker> markers = {};

  String dateFormat(String date) {
    // String date = orderData['created_at'].toString();
    DateTime dt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
    var inputDate = DateTime.parse(dt.toString());
    var outputFormat = DateFormat('dd-MM-yyyy  hh:mm:ss ');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
    // log(outputDate.toString());
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: StreamBuilder(
            stream: getOrderDetailsRXobj.getOrderDetailsData,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                Map orderData = snapshot.data['data']['order'];
                Map customerData = orderData['customer'];

                List<dynamic> statusHistory =
                    snapshot.data['data']['order']['status_histories'];
                items = orderData['order_items'];

                log(statusHistory.toString());

                log(orderData['id'].toString());
                // for (int i = 0; i <= statusHistory.length; i++) {
                //   int? orderS = statusHistory[i]['order_status'];
                //   log('Order is $orderS');
                // }
                for (var element in statusHistory) {
                  var story = element['order_status'];
                  log('Order is $story');
                }
                markers.add(
                  Marker(
                    markerId: const MarkerId('Shop'),
                    position: LatLng(
                      double.parse(customerData['latitude']),
                      double.parse(
                        customerData['longitude'],
                      ),
                    ),
                    infoWindow: const InfoWindow(title: 'Shop'),
                    rotation: 0,
                  ),
                );
                markers.add(
                  Marker(
                    markerId: const MarkerId('Customer'),
                    position: LatLng(
                      double.parse(orderData['latitude']),
                      double.parse(
                        orderData['longitude'],
                      ),
                    ),
                    infoWindow: const InfoWindow(title: 'Customer'),
                    rotation: 0,
                  ),
                );

                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: UIHelper.kDefaulutPadding(),
                      vertical: UIHelper.kDefaulutPadding()),
                  child: Column(
                    children: [
                      Text(
                        'Order Detail (${orderData['order_code']}) ',
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      UIHelper.verticalSpaceMedium,
                      Column(
                        children: [
                          (ScreenUtil().screenWidth < 600)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: items.length,
                                  itemBuilder: (_, index) {
                                    return Card(
                                      elevation: 3.0,
                                      margin: EdgeInsets.only(bottom: 10.h),
                                      child: Padding(
                                        padding: EdgeInsets.all(10.w),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Item name',
                                                      style: TextFontStyle
                                                          .mobileBold,
                                                    ),
                                                    Text(
                                                      items[index]['name'],
                                                      style: TextFontStyle
                                                          .mobileBold
                                                          .copyWith(
                                                              color: AppColors
                                                                  .disabledColor),
                                                    ),
                                                    UIHelper.verticalSpaceSmall,
                                                    Text(
                                                      'Quantity',
                                                      style: TextFontStyle
                                                          .mobileBold,
                                                    ),
                                                    Text(
                                                      items[index]['quantity']
                                                          .toString(),
                                                      style: TextFontStyle
                                                          .mobileNormal
                                                          .copyWith(
                                                              color: AppColors
                                                                  .disabledColor),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r),
                                                      child: Image.network(
                                                        items[index]['food']
                                                            ['image_full_path'],
                                                        fit: BoxFit.cover,
                                                        width: 80.h,
                                                        height: 80.h,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            UIHelper.verticalSpaceMedium,
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Special Request',
                                                      style: TextFontStyle
                                                          .mobileBold,
                                                    ),
                                                    Text(
                                                      (items[index][
                                                                  'special_request'] ==
                                                              null)
                                                          ? 'N/A'
                                                          : items[index][
                                                                  'special_request']
                                                              .toString(),
                                                      style: TextFontStyle
                                                          .mobileNormal
                                                          .copyWith(
                                                              color: AppColors
                                                                  .disabledColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            UIHelper.verticalSpaceSmall,
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Unit Price',
                                                      style: TextFontStyle
                                                          .mobileBold,
                                                    ),
                                                    Text(
                                                      items[index][
                                                          'unit_price_in_euro'],
                                                      style: TextFontStyle
                                                          .mobileNormal
                                                          .copyWith(
                                                              color: AppColors
                                                                  .disabledColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            UIHelper.verticalSpaceSmall,
                                            Row(
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Total',
                                                      style: TextFontStyle
                                                          .mobileBold,
                                                    ),
                                                    Text(
                                                      orderData[
                                                          'item_total_price_in_euro'],
                                                      style: TextFontStyle
                                                          .mobileNormal
                                                          .copyWith(
                                                              color: AppColors
                                                                  .disabledColor),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            UIHelper.verticalSpaceMedium,
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerColor: AppColors.scaffoldColor),
                                    child: DataTable(
                                        columnSpacing: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? .05.sw
                                            : .08.sw,
                                        headingTextStyle:
                                            TextFontStyle.tableHeader.copyWith(
                                          color: const Color(0xFF8D949B),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.sp,
                                        ),
                                        headingRowColor:
                                            MaterialStateProperty.all(
                                                const Color(0xFFDEE2E6)),
                                        dataRowHeight: 60.h,
                                        // horizontalMargin: 10,
                                        dividerThickness: 5,
                                        dataTextStyle:
                                            TextFontStyle.headline2BoldStyle,
                                        border: TableBorder(
                                          horizontalInside: BorderSide.lerp(
                                              const BorderSide(
                                                  color: Colors.black12),
                                              const BorderSide(
                                                  color: Colors.black12),
                                              10),
                                        ),
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text('',
                                                style:
                                                    TextFontStyle.tableHeader,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left),
                                          ),
                                          DataColumn(
                                            label: Text('Item Name',
                                                style:
                                                    TextFontStyle.tableHeader,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left),
                                          ),
                                          DataColumn(
                                            label: Text('Quantity',
                                                style:
                                                    TextFontStyle.tableHeader,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left),
                                          ),
                                          DataColumn(
                                            label: Text('Special Request',
                                                style:
                                                    TextFontStyle.tableHeader,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left),
                                          ),
                                          DataColumn(
                                            label: Text('Unit Price',
                                                style:
                                                    TextFontStyle.tableHeader,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left),
                                          ),
                                          DataColumn(
                                            label: Text('Total',
                                                style:
                                                    TextFontStyle.tableHeader,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left),
                                          ),
                                        ],
                                        rows: items
                                            .map(
                                              (items) => DataRow(cells: [
                                                DataCell(
                                                  Image.network(
                                                    items['food']
                                                        ['image_full_path'],
                                                    fit: BoxFit.cover,
                                                    width: 50.h,
                                                    height: 50.h,
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(items['name']),
                                                ),
                                                DataCell(
                                                  Text(items['quantity']
                                                      .toString()),
                                                ),
                                                DataCell(
                                                  (items['special_request'] ==
                                                          null)
                                                      ? Text('N/A')
                                                      : Text(items[
                                                              'special_request']
                                                          .toString()),
                                                ),
                                                DataCell(
                                                  Text(items[
                                                      'unit_price_in_euro']),
                                                ),
                                                DataCell(
                                                  Text(orderData[
                                                      'item_total_price_in_euro']),
                                                ),
                                              ]),
                                            )
                                            .toList()),
                                  ),
                                ),
                          UIHelper.verticalSpaceSmall,
                          UIHelper.verticalSpaceMedium,
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Item Total :  ${orderData['item_total_price']} \€',
                                  style: TextFontStyle.headline2BoldStyle,
                                ),
                                UIHelper.verticalSpaceSmall,
                                Text(
                                  'Delivery Charge :  ${orderData['delivery_charge_in_euro']}',
                                  style: TextFontStyle.headline2BoldStyle,
                                ),
                                UIHelper.verticalSpaceSmall,
                                Text(
                                  'Total :  ${orderData['total_price_in_euro']}',
                                  style: TextFontStyle.headline2BoldStyle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpaceMedium,
                      UIHelper.verticalSpaceMedium,
                      Container(
                        width: double.infinity,
                        height: 300.h,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          scrollGesturesEnabled: true,
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>[
                            Factory<OneSequenceGestureRecognizer>(
                              () => EagerGestureRecognizer(),
                            ),
                          ].toSet(),
                          zoomGesturesEnabled: true,
                          mapType: mapType,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              double.parse(orderData['latitude']),
                              double.parse(
                                orderData['longitude'],
                              ),
                            ),
                            zoom: 9.0,
                          ),
                          markers: markers,
                        ),
                      ),

                      UIHelper.verticalSpaceMedium,
                      //This Row for Delivery and Income info

                      //ForMobile
                      (ScreenUtil().screenWidth < 600)
                          ? Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    margin: const EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    elevation: 1.0,
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 15.h),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Delivery Info",
                                              style: TextFontStyle
                                                  .headline1BoldStyle
                                                  .copyWith(
                                                      color: Colors.black,
                                                      letterSpacing: 1,
                                                      fontSize: 18.sp),
                                            ),
                                            UIHelper.verticalSpaceMedium,
                                            Text(
                                              "PickUp: ${orderData['pickup_date_time']}",
                                              style: TextFontStyle
                                                  .headline1RegularStyle
                                                  .copyWith(
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                            ),
                                            UIHelper.verticalSpaceSmall,
                                            Text(
                                              "Delivery: ${orderData['expected_delivery_time']}",
                                              style: TextFontStyle
                                                  .headline1RegularStyle
                                                  .copyWith(
                                                      color: Colors.black
                                                          .withOpacity(0.8)),
                                            ),
                                            UIHelper.verticalSpaceSmall,
                                          ]),
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpaceMedium,
                                Card(
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  elevation: 1.0,
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Track Order",
                                            style: TextFontStyle
                                                .headline1BoldStyle
                                                .copyWith(
                                                    color: Colors.black,
                                                    letterSpacing: 1,
                                                    fontSize: 18.sp),
                                          ),
                                          UIHelper.verticalSpaceMedium,
                                          if (orderData['created_at'] != '')
                                            TrackingWidget(
                                              title: 'Order Placed',
                                              time: dateFormat(
                                                  orderData['created_at']
                                                      .toString()),
                                              lastVal: false,
                                            ),
                                          ListView.builder(
                                              itemCount: statusHistory.length,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                if (statusHistory[index]
                                                        ['order_status'] !=
                                                    null) {
                                                  switch (statusHistory[index]
                                                          ['order_status']
                                                      .toString()) {
                                                    case '0':
                                                      orderStatusInfo =
                                                          'Order Placed';
                                                      break;
                                                    case '10':
                                                      orderStatusInfo =
                                                          'Accepted';
                                                      break;
                                                    case '20':
                                                      orderStatusInfo =
                                                          'Food Processing';

                                                      break;
                                                    case '21':
                                                      orderStatusInfo =
                                                          'Food Ready';
                                                      break;
                                                    case '30':
                                                      orderStatusInfo =
                                                          'Food Picked';

                                                      break;
                                                    case '40':
                                                      orderStatusInfo =
                                                          'Food Delivered';
                                                      lastVal = true;

                                                      break;
                                                    case '80':
                                                      orderStatusInfo =
                                                          'Cancled';

                                                      break;
                                                    case '90':
                                                      orderStatusInfo =
                                                          'Rejected by Shop';

                                                      break;
                                                    case '100':
                                                      orderStatusInfo =
                                                          'Failled';
                                                      break;
                                                  }

                                                  return TrackingWidget(
                                                      title: orderStatusInfo,
                                                      time: (statusHistory[
                                                                      index][
                                                                  'order_status'] !=
                                                              null)
                                                          ? dateFormat(
                                                              statusHistory[
                                                                          index]
                                                                      [
                                                                      'created_at']
                                                                  .toString())
                                                          : '',
                                                      lastVal: false);
                                                }
                                                return Container();
                                              }),
                                          UIHelper.verticalSpaceSmall,
                                        ]),
                                  ),
                                ),

                                UIHelper.verticalSpaceMedium,
                                Card(
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  elevation: 1.0,
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Customer Delivery Info",
                                            style: TextFontStyle
                                                .headline1BoldStyle
                                                .copyWith(
                                                    color: Colors.black,
                                                    letterSpacing: 1,
                                                    fontSize: 18.sp),
                                          ),
                                          UIHelper.verticalSpaceMedium,
                                          Text(
                                            "Name: ${customerData['last_name']}",
                                            style: TextFontStyle
                                                .headline1RegularStyle
                                                .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                          ),
                                          UIHelper.verticalSpaceSmall,
                                          Text(
                                            "Address: ${customerData['address']}",
                                            style: TextFontStyle
                                                .headline1RegularStyle
                                                .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                          ),
                                          UIHelper.verticalSpaceSmall,
                                          Text(
                                            "Contact Number:${customerData['phone']}",
                                            style: TextFontStyle
                                                .headline1RegularStyle
                                                .copyWith(
                                                    color: Colors.black
                                                        .withOpacity(0.8)),
                                          ),
                                        ]),
                                  ),
                                ),

                                UIHelper.verticalSpaceMedium,
                                if (orderData['delivery_man'] != null)
                                  SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      margin: const EdgeInsets.all(0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      elevation: 1.0,
                                      color: AppColors.white,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 15.h),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Delivery man's Info",
                                                style: TextFontStyle
                                                    .headline1BoldStyle
                                                    .copyWith(
                                                        color: Colors.black,
                                                        letterSpacing: 1,
                                                        fontSize: 18.sp),
                                              ),
                                              UIHelper.verticalSpaceMedium,
                                              Text(
                                                "Name: ${orderData['delivery_man']['first_name'] + ' ' + orderData['delivery_man']['last_name']}",
                                                style: TextFontStyle
                                                    .headline1BoldStyle
                                                    .copyWith(
                                                        color: Colors.black
                                                            .withOpacity(0.8)),
                                              ),
                                              UIHelper.verticalSpaceSmall,
                                              Text(
                                                "Address: ${orderData['delivery_man']['address']}",
                                                style: TextFontStyle
                                                    .headline1RegularStyle
                                                    .copyWith(
                                                        color: Colors.black
                                                            .withOpacity(0.8)),
                                              ),
                                              UIHelper.verticalSpaceSmall,
                                              Text(
                                                "Phone: ${orderData['delivery_man']['phone']}",
                                                style: TextFontStyle
                                                    .headline1RegularStyle
                                                    .copyWith(
                                                        color: Colors.black
                                                            .withOpacity(0.8)),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                // UIHelper.verticalSpaceSmall,
                                //Order Note
                                UIHelper.verticalSpaceMedium,
                                SizedBox(
                                  width: double.infinity,
                                  child: Card(
                                    margin: const EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    elevation: 1.0,
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 15.h),
                                      child: Text(
                                        "Order Note",
                                        style: TextFontStyle.headline1BoldStyle
                                            .copyWith(
                                                color: Colors.black,
                                                letterSpacing: 1,
                                                fontSize: 18.sp),
                                      ),
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpaceMedium,

                                Card(
                                  margin: const EdgeInsets.all(0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  elevation: 1.0,
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Track Delivery Man",
                                          style: TextFontStyle
                                              .headline1BoldStyle
                                              .copyWith(
                                                  color: Colors.black,
                                                  letterSpacing: 1,
                                                  fontSize: 18.sp),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: Colors.red),
                                          child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 8.h),
                                              child:
                                                  (orderData['delivered_on_time']
                                                              .toString() ==
                                                          '0')
                                                      ? Text(
                                                          'Delivery not on time',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15.sp),
                                                        )
                                                      : Text(
                                                          'Delivery on time',
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15.sp),
                                                        )),
                                        ),
                                        UIHelper.verticalSpaceMedium,
                                        ListView.builder(
                                            itemCount: statusHistory.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              if (statusHistory[index]
                                                      ['delivery_status'] !=
                                                  null) {
                                                switch (statusHistory[index]
                                                        ['delivery_status']
                                                    .toString()) {
                                                  case '10':
                                                    deliveryStatusInfo =
                                                        'Confirmed';
                                                    break;
                                                  case '11':
                                                    deliveryStatusInfo =
                                                        'Delivery Started';

                                                    break;
                                                  case '20':
                                                    deliveryStatusInfo =
                                                        'Arrived at Shop';
                                                    break;
                                                  case '30':
                                                    deliveryStatusInfo =
                                                        'On Transit';

                                                    break;
                                                  case '40':
                                                    deliveryStatusInfo =
                                                        'Delivered';
                                                }

                                                return TrackingWidget(
                                                    title: deliveryStatusInfo,
                                                    time: (statusHistory[index][
                                                                'delivery_status'] !=
                                                            null)
                                                        ? dateFormat(
                                                            statusHistory[index]
                                                                    [
                                                                    'created_at']
                                                                .toString())
                                                        : '',
                                                    lastVal: false);
                                              }
                                              return Container();
                                            }),
                                      ],
                                    ),
                                  ),
                                ),

                                UIHelper.verticalSpaceMedium,
                                UIHelper.verticalSpaceMedium,
                              ],
                            )

                          //For Tab

                          : Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        margin: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        elevation: 1.0,
                                        color: AppColors.white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 15.h),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Delivery Info",
                                                  style: TextFontStyle
                                                      .headline1BoldStyle
                                                      .copyWith(
                                                          color: Colors.black,
                                                          letterSpacing: 1,
                                                          fontSize: 18.sp),
                                                ),
                                                UIHelper.verticalSpaceMedium,
                                                Text(
                                                  "PickUp: ${orderData['pickup_date_time']}",
                                                  style: TextFontStyle
                                                      .headline1RegularStyle
                                                      .copyWith(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8)),
                                                ),
                                                UIHelper.verticalSpaceSmall,
                                                Text(
                                                  "Delivery: ${orderData['expected_delivery_time']}",
                                                  style: TextFontStyle
                                                      .headline1RegularStyle
                                                      .copyWith(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8)),
                                                ),
                                                UIHelper.verticalSpaceSmall,
                                              ]),
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpaceSmall,
                                    Expanded(
                                      child: Card(
                                        margin: const EdgeInsets.all(0),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        elevation: 1.0,
                                        color: AppColors.white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w, vertical: 15.h),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Customer Delivery Info",
                                                  style: TextFontStyle
                                                      .headline1BoldStyle
                                                      .copyWith(
                                                          color: Colors.black,
                                                          letterSpacing: 1,
                                                          fontSize: 18.sp),
                                                ),
                                                UIHelper.verticalSpaceMedium,
                                                Text(
                                                  "Name: ${customerData['last_name']}",
                                                  style: TextFontStyle
                                                      .headline1RegularStyle
                                                      .copyWith(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8)),
                                                ),
                                                UIHelper.verticalSpaceSmall,
                                                Text(
                                                  "Address: ${customerData['address']}",
                                                  style: TextFontStyle
                                                      .headline1RegularStyle
                                                      .copyWith(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8)),
                                                ),
                                                UIHelper.verticalSpaceSmall,
                                                Text(
                                                  "Contact Number:${customerData['phone']}",
                                                  style: TextFontStyle
                                                      .headline1RegularStyle
                                                      .copyWith(
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.8)),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                UIHelper.verticalSpaceMedium,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                            margin: const EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            elevation: 1.0,
                                            color: AppColors.white,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w,
                                                  vertical: 15.h),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Track Order",
                                                      style: TextFontStyle
                                                          .headline1BoldStyle
                                                          .copyWith(
                                                              color:
                                                                  Colors.black,
                                                              letterSpacing: 1,
                                                              fontSize: 18.sp),
                                                    ),
                                                    UIHelper
                                                        .verticalSpaceMedium,
                                                    if (orderData[
                                                            'created_at'] !=
                                                        '')
                                                      TrackingWidget(
                                                        title: 'Order Placed',
                                                        time: dateFormat(
                                                            orderData[
                                                                    'created_at']
                                                                .toString()),
                                                        lastVal: false,
                                                      ),
                                                    ListView.builder(
                                                        itemCount: statusHistory
                                                            .length,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          if (statusHistory[
                                                                      index][
                                                                  'order_status'] !=
                                                              null) {
                                                            switch (statusHistory[
                                                                        index][
                                                                    'order_status']
                                                                .toString()) {
                                                              case '0':
                                                                orderStatusInfo =
                                                                    'Order Placed';
                                                                break;
                                                              case '10':
                                                                orderStatusInfo =
                                                                    'Accepted';
                                                                break;
                                                              case '20':
                                                                orderStatusInfo =
                                                                    'Food Processing';

                                                                break;
                                                              case '21':
                                                                orderStatusInfo =
                                                                    'Food Ready';
                                                                break;
                                                              case '30':
                                                                orderStatusInfo =
                                                                    'Food Picked';

                                                                break;
                                                              case '40':
                                                                orderStatusInfo =
                                                                    'Food Delivered';
                                                                lastVal = true;

                                                                break;
                                                              case '80':
                                                                orderStatusInfo =
                                                                    'Cancled';

                                                                break;
                                                              case '90':
                                                                orderStatusInfo =
                                                                    'Rejected by Shop';

                                                                break;
                                                              case '100':
                                                                orderStatusInfo =
                                                                    'Failled';
                                                                break;
                                                            }

                                                            return TrackingWidget(
                                                                title:
                                                                    orderStatusInfo,
                                                                time: (statusHistory[index]
                                                                            [
                                                                            'order_status'] !=
                                                                        null)
                                                                    ? dateFormat(statusHistory[index]
                                                                            [
                                                                            'created_at']
                                                                        .toString())
                                                                    : '',
                                                                lastVal: false);
                                                          }
                                                          return Container();
                                                        }),
                                                    UIHelper.verticalSpaceSmall,
                                                  ]),
                                            ),
                                          ),
                                          UIHelper.verticalSpaceMedium,
                                          if (orderData['delivery_man'] != null)
                                            SizedBox(
                                              width: .5.sw,
                                              child: Card(
                                                margin: const EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r)),
                                                elevation: 1.0,
                                                color: AppColors.white,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15.w,
                                                      vertical: 15.h),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Delivery man's Info",
                                                          style: TextFontStyle
                                                              .headline1BoldStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black,
                                                                  letterSpacing:
                                                                      1,
                                                                  fontSize:
                                                                      18.sp),
                                                        ),
                                                        UIHelper
                                                            .verticalSpaceMedium,
                                                        Text(
                                                          "Name: ${orderData['delivery_man']['first_name'] + ' ' + orderData['delivery_man']['last_name']}",
                                                          style: TextFontStyle
                                                              .headline1BoldStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8)),
                                                        ),
                                                        UIHelper
                                                            .verticalSpaceSmall,
                                                        Text(
                                                          "Address: ${orderData['delivery_man']['address']}",
                                                          style: TextFontStyle
                                                              .headline1RegularStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8)),
                                                        ),
                                                        UIHelper
                                                            .verticalSpaceSmall,
                                                        Text(
                                                          "Phone: ${orderData['delivery_man']['phone']}",
                                                          style: TextFontStyle
                                                              .headline1RegularStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8)),
                                                        ),
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          UIHelper.verticalSpaceMedium,
                                          //Order Note
                                          SizedBox(
                                            width: .5.sw,
                                            child: Card(
                                              margin: const EdgeInsets.all(0),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              elevation: 1.0,
                                              color: AppColors.white,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15.w,
                                                    vertical: 15.h),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Order Note",
                                                        style: TextFontStyle
                                                            .headline1BoldStyle
                                                            .copyWith(
                                                                color: Colors
                                                                    .black,
                                                                letterSpacing:
                                                                    1,
                                                                fontSize:
                                                                    18.sp),
                                                      ),
                                                      UIHelper
                                                          .verticalSpaceMedium,
                                                    ]),
                                              ),
                                            ),
                                          ),
                                          UIHelper.verticalSpaceMedium,
                                        ],
                                      ),
                                    ),
                                    UIHelper.horizontalSpaceSmall,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Card(
                                            margin: const EdgeInsets.all(0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            elevation: 1.0,
                                            color: AppColors.white,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w,
                                                  vertical: 15.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Track Delivery Man",
                                                    style: TextFontStyle
                                                        .headline1BoldStyle
                                                        .copyWith(
                                                            color: Colors.black,
                                                            letterSpacing: 1,
                                                            fontSize: 18.sp),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                        color: Colors.red),
                                                    child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8.w,
                                                                vertical: 8.h),
                                                        child: (orderData[
                                                                        'delivered_on_time']
                                                                    .toString() ==
                                                                '0')
                                                            ? Text(
                                                                'Delivery not on time',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15.sp),
                                                              )
                                                            : Text(
                                                                'Delivery on time',
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15.sp),
                                                              )),
                                                  ),
                                                  UIHelper.verticalSpaceMedium,
                                                  ListView.builder(
                                                      itemCount:
                                                          statusHistory.length,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        if (statusHistory[index]
                                                                [
                                                                'delivery_status'] !=
                                                            null) {
                                                          switch (statusHistory[
                                                                      index][
                                                                  'delivery_status']
                                                              .toString()) {
                                                            case '10':
                                                              deliveryStatusInfo =
                                                                  'Confirmed';
                                                              break;
                                                            case '11':
                                                              deliveryStatusInfo =
                                                                  'Delivery Started';

                                                              break;
                                                            case '20':
                                                              deliveryStatusInfo =
                                                                  'Arrived at Shop';
                                                              break;
                                                            case '30':
                                                              deliveryStatusInfo =
                                                                  'On Transit';

                                                              break;
                                                            case '40':
                                                              deliveryStatusInfo =
                                                                  'Delivered';
                                                          }

                                                          return TrackingWidget(
                                                              title:
                                                                  deliveryStatusInfo,
                                                              time: (statusHistory[
                                                                              index]
                                                                          [
                                                                          'delivery_status'] !=
                                                                      null)
                                                                  ? dateFormat(
                                                                      statusHistory[index]
                                                                              [
                                                                              'created_at']
                                                                          .toString())
                                                                  : '',
                                                              lastVal: false);
                                                        }
                                                        return Container();
                                                      }),
                                                ],
                                              ),
                                            ),
                                          ),
                                          UIHelper.verticalSpaceMedium,
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                loadingIndicatorCircle(context: context);
              }
              return const SizedBox.shrink();
            }),
      ),
    );
  }
}
