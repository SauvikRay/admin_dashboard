import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

class PostProductAddonApi {
  Future<Map> postProductAddon(int? addOnId, int? foodId, String name,
      String price, File? icon, String description) async {
    FormData formData = FormData.fromMap({
      'restaurant_food_id': foodId,
      'name': name,
      'price': price,
      'description': description,
      'id': addOnId,
    });
    if (icon != null) {
      formData.files.addAll([
        MapEntry(
          'icon',
          await MultipartFile.fromFile(icon.path),
        ),
      ]);
    }

    final response = await postHttp(Endpoints.postProductAddonSave(), formData);
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
