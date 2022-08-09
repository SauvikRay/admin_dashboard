import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helpers/dio/dio.dart';
import '../../helpers/navigation_service.dart';
import '../../widgets/loading_indicators.dart';
import '../endpoints.dart';

class GetOrdersApi {
  Future<Map> fetchOrdersData(String status, {int? record, int? page}) async {
    final _response = await postHttp(
      Endpoints.getOrders(status, record: record ?? 10, page: page ?? 1),
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
