import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

class PostSaveShopBasicApi {
  Future<Map> postSaveShopBasic(
    String name,
    String restaurantGroupId,
    String userId,
    String restaurantCategoryId,
    List<String> subCategoryIds,
    String iban,
    String nif,
    String shortDescription,
    String description, {
    String? status,
    String? id,
    File? featuredImage,
  }) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "restaurant_group_id": restaurantGroupId,
      "user_id": userId,
      "manager_id": "",
      "restaurant_category_id": restaurantCategoryId,
      "iban": iban,
      "tax_id": nif,
      "sub_category_ids": subCategoryIds,
      "short_description": shortDescription,
      "description": description,
    });

    if (featuredImage != null) {
      formData.files.addAll([
        MapEntry(
          'featured_image',
          await MultipartFile.fromFile(featuredImage.path),
        ),
      ]);
    }

    if (id != null) {
      formData.fields.add(
        MapEntry(
          'id',
          id.toString(),
        ),
      );
    }
    if (status != null) {
      formData.fields.add(
        MapEntry(
          'status',
          status,
        ),
      );
    }

    log(formData.fields.toString());
    final response = await postHttp(Endpoints.postSaveShopBasic(), formData);
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
