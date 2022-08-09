import 'dart:convert';

import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

class GetProductShowApi {
  Future<Map> fetchProductShow(String foodId) async {
    final response = await getHttp(Endpoints.getShowShopProduct(foodId));

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      return data;
    }
    Map empty = {};
    return empty;
  }
}
