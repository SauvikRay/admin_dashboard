import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../helpers/dio/dio.dart';
import '../endpoints.dart';

class GetDashOrderListApi {
  Future<Map> fetchDashBoardOrderListData({int? record, int? page}) async {
    final _response = await postHttp(
      Endpoints.getDashBoardOrderList(record: record ?? 10, page: page ?? 1),
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
