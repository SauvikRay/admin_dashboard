import 'dart:convert';

import 'package:flutter/foundation.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';
import '../../helpers/dio/dio.dart';

class GetProductCategoryApi {
  Future<Map> fetchProductCategoryData(String restaurantId) async {
    final response = await getHttp(Endpoints.getProductCategory(restaurantId));

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
