import 'dart:convert';
import 'package:flutter/foundation.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

class GetShopCategoryPopupListApi {
  Future<Map> fetchShopCategoryPopupList() async {
    final response = await getHttp(Endpoints.getShopCategory());
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
