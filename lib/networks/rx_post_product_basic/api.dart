import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

class PostProductBasicApi {
  Future<Map> postProductBasic(
      String name,
      String foodCategoryId,
      String description,
      String status,
      String shortDescription,
      String restaurantId,
      String? featuredImage,
      {String? id}) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'food_category_id': foodCategoryId,
      'description': description,
      'status': status,
      'short_description': shortDescription,
      'restaurant_id': restaurantId,
    });
    if (featuredImage != null) {
      formData.fields.addAll([
        MapEntry(
          'featured_image',
          featuredImage,
        ),
      ]);
    }

    if (id != null) {
      formData.fields.addAll([
        MapEntry(
          'id',
          id,
        ),
      ]);
    }

    log(formData.toString());

    final response = await postHttp(Endpoints.postProductBasic(), formData);
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
