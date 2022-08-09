import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../helpers/dio/dio.dart';
import '../endpoints.dart';

class DeleteProductCategoryApi {
  Future<Map> deleteCategory(String id) async {
    final _response = await deleteHttp(
      Endpoints.deleteProductCategory(id),
    );

    if (_response.statusCode == 200) {
      Map data = json.decode(json.encode(_response.data));
      return data;
    }
    if (kDebugMode) {
      print(_response.toString);
    }
    Map empty = {};
    return empty;
  }
}
