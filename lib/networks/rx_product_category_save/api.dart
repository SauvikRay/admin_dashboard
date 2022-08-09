import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

class PostProductCategorySaveApi {
  Future<Map> postProductCategory(
      String name, String restaurantId, File? icon, String status) async {
    FormData formData = FormData.fromMap({
      'name': name,
      'restaurant_id': restaurantId,
      'status': status,
    });

    formData.files.addAll([
      MapEntry(
        'icon',
        await MultipartFile.fromFile(icon!.path),
      ),
    ]);

    final response =
        await postHttp(Endpoints.postProductCategorySave(), formData);
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
