import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/app_constants.dart';
import '../../helpers/dio/dio.dart';
import '../endpoints.dart';

class GetShopHolidaysListApi {
  Future<Map> getShopHolidaysList() async {
    final storage = GetStorage();
    String shopId = storage.read(kKeyShopID);

    final _response = await getHttp(Endpoints.getShopSchedule(shopId));

    if (_response.statusCode == 200) {
      Map data = json.decode(json.encode(_response.data));
      return data;
    }
    if (kDebugMode) {
      print(_response.toString);
    }
    Map empty = {};
    return empty;
  }
}
