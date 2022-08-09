import 'dart:convert';

import 'package:flutter/foundation.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

class DeleteProductAddonApi {
  Future<Map> deleteProductAddon(String addonId) async {
    final response = await deleteHttp(Endpoints.deleteProductAddon(addonId));
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
