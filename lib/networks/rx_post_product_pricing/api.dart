import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../helpers/dio/dio.dart';
import '../endpoints.dart';

class PostProductPriceApi {
  Future<Map> postProductPrice(String name, String price, int isDefault,
      String description, int restaurantFoodId,
      {int? optionId}) async {
    FormData formData = FormData.fromMap({
      "description": description,
      "restaurant_food_id": restaurantFoodId,
      "name": name,
      "price": price,
      "is_default": isDefault
    });
    if (optionId != null) {
      formData.fields.add(
        MapEntry(
          'id',
          optionId.toString(),
        ),
      );
    }

    final response = await postHttp(Endpoints.postProductPriching(), formData);
    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      log(data.toString());
      return data;
    }
    if (kDebugMode) {
      print(response.toString);
    }
    Map empty = {};
    return empty;
  }
}
