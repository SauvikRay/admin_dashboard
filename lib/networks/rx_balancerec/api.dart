import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/app_constants.dart';
import '../../helpers/dio/dio.dart';
import '../endpoints.dart';

class GetBalanceRecApi {
  Future<Map> fetchBalanceRecData({int? record, int? page}) async {
    final storage = GetStorage();
    String userID = storage.read(kKeyUserID);
    final _response = await postHttp(
      Endpoints.getBalanceRecord(userID, record: record ?? 10, page: page ?? 1),
    );

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
