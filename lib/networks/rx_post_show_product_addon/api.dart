import 'dart:convert';

import 'package:flutter/foundation.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

class ShowPostProductAddonApi {
  Future<Map> showPostProductaddon(String foodId,
      {int? record, int? page}) async {
    final response = await postHttp(Endpoints.postShowProductAddon(foodId,
        record: record ?? 10, page: page ?? 1));
    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      return data;
    }
    if (kDebugMode) {
      print(response.toString);
    }
    Map empty = {};
    return empty;
  }
}
