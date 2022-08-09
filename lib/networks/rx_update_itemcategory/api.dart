import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helpers/dio/dio.dart';
import '../../helpers/navigation_service.dart';
import '../../widgets/loading_indicators.dart';
import '../endpoints.dart';

class UpdateItemCategoryApi {
  Future<Map> updateItemCategory(Map<String, dynamic> data, File icon) async {
    showDialog(
      context: NavigationService.context,
      builder: (context) => loadingIndicatorCircle(context: context),
    );

    FormData formData = FormData.fromMap(data);

    formData.files.addAll([
      MapEntry(
        'icon',
        await MultipartFile.fromFile(icon.path),
      ),
    ]);

    final _response = await postHttp(
      Endpoints.updateShopCategory(),
      formData,
    );

    if (_response.statusCode == 200) {
      NavigationService.goBack;
      Map data = json.decode(json.encode(_response.data));
      
      
      return data;
    }
    NavigationService.goBack;
    if (kDebugMode) {
      print(_response.toString);
    }
    Map empty = {};
    return empty;
  }
}
