import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../constants/app_color.dart';
import '../constants/app_constants.dart';

final appdata = GetStorage();

enum StatusType { order, delivery }

Color statuscolor(StatusType status, String statusCode) {
  late Color stcolor;
  if (StatusType.order == status) {
    switch (statusCode) {
      case OrderStatusNo.kPENDING:
        stcolor = OrderStatusColor.kPENDING;
        break;
      case OrderStatusNo.kACCEPTED:
        stcolor = OrderStatusColor.kACCEPTED;
        break;
      case OrderStatusNo.kFOODPROCESSING:
        stcolor = OrderStatusColor.kFOODPROCESSING;
        break;
      case OrderStatusNo.kFOODREADY:
        stcolor = OrderStatusColor.kFOODREADY;
        break;
      case OrderStatusNo.kFOODPICKED:
        stcolor = OrderStatusColor.kFOODPICKED;
        break;
      case OrderStatusNo.kFOODDELIVERED:
        stcolor = OrderStatusColor.kFOODDELIVERED;
        break;
      case OrderStatusNo.kCANCELLED:
        stcolor = OrderStatusColor.kCANCELLED;
        break;
      case OrderStatusNo.kREJECTEDBYSHOP:
        stcolor = OrderStatusColor.kREJECTEDBYSHOP;
        break;
      case OrderStatusNo.kFAILED:
        stcolor = OrderStatusColor.kFAILED;
        break;
    }
  }
  if (StatusType.delivery == status) {
    switch (statusCode) {
      case DeliveryStatusNo.kPENDIG:
        stcolor = DeliveryStatusColor.kPENDING;
        break;
      case DeliveryStatusNo.kONTRANSIT:
        stcolor = DeliveryStatusColor.kONTRANSIT;
        break;
      case DeliveryStatusNo.kARRIVEDATSHOP:
        stcolor = DeliveryStatusColor.kARRIVEDATSHOP;
        break;
      case DeliveryStatusNo.kDELIVERYMANCONFIRMED:
        stcolor = DeliveryStatusColor.kDELIVERYMANCONFIRMED;
        break;
      case DeliveryStatusNo.kDELIVERYSTARTED:
        stcolor = DeliveryStatusColor.kDELIVERYSTARTED;
        break;
      case DeliveryStatusNo.kDELIVERED:
        stcolor = DeliveryStatusColor.kDELIVERED;
        break;
    }
  }

  return stcolor;
}

Future<String?> networkImageToBase64(String imageUrl) async {
  http.Response response = await http.get(Uri.parse(imageUrl));
  final bytes = response.bodyBytes;
  // ignore: unnecessary_null_comparison
  return (bytes != null ? base64Encode(bytes) : null);
}

// getlocation() async {
//   loc.Location location = locator<loc.Location>();
//   bool serviceEnabled;
//   loc.PermissionStatus permissionGranted;
//   serviceEnabled = await location.serviceEnabled();
//   if (!serviceEnabled) {
//     serviceEnabled = await location.requestService();
//     if (!serviceEnabled) {
//       return;
//     }
//   }
//   permissionGranted = await location.hasPermission();
//   if (permissionGranted == loc.PermissionStatus.denied) {
//     permissionGranted = await location.requestPermission();
//     if (permissionGranted != loc.PermissionStatus.granted) {
//       return;
//     }
//   }
// }

// Future<Map<String, dynamic>> getAddressFromLatLng(
//     double lat, double long) async {
//   Map<String, dynamic> addressDetail = {};
//   await placemarkFromCoordinates(lat, long).then((List<Placemark> placemarks) {
//     Placemark place = placemarks[0];
//     addressDetail = {
//       "street": place.street,
//       "sublocal": place.subLocality,
//       "subadarea": place.subAdministrativeArea,
//       "postcode": place.postalCode
//     };
//   });
//   return addressDetail;
// }

extension TimeOfDayConverter on TimeOfDay {
  String to24hours() {
    final hour = this.hour.toString().padLeft(2, "0");
    final min = minute.toString().padLeft(2, "0");
    return "$hour:$min";
  }
}

TimeOfDay formattedTnD(String time) {
  List<String> sp = time.split(':');
  int h = int.parse(sp[0]);
  int m = int.parse(sp[1]);
  return TimeOfDay(hour: h, minute: m);
}

DateTime formatDateTime(String data) {
  var inputFormat = DateFormat('dd-MM-yyyy'); //16-07-2022
  var inputDate = inputFormat.parse(data);

  var outputFormatY = DateFormat('yyyy');
  var outputFormatM = DateFormat('MM');
  var outputFormatD = DateFormat('dd');
  var outputDateY = int.parse(outputFormatY.format(inputDate));
  var outputDateM = int.parse(outputFormatM.format(inputDate));
  var outputDateD = int.parse(outputFormatD.format(inputDate));

  return DateTime(outputDateY, outputDateM, outputDateD);
}

String dateFormat(String date) {
  // String date = orderData['created_at'].toString();
  DateTime dt = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  var inputDate = DateTime.parse(dt.toString());
  var outputFormat = DateFormat('dd-MM-yyyy  hh:mm:ss ');
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
  // log(outputDate.toString());
}

setId() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    appdata.writeIfNull(
        kKeyDeviceID, iosDeviceInfo.identifierForVendor); // unique ID on iOS
  } else if (Platform.isAndroid) {
    var androidDeviceInfo =
        await deviceInfo.androidInfo; // unique ID on Android
    appdata.writeIfNull(kKeyDeviceID, androidDeviceInfo.id);
  }
}
