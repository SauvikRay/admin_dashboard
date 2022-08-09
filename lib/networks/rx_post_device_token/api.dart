import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '/constants/app_constants.dart';

import '../../helpers/dio/dio.dart';
import '../../helpers/navigation_service.dart';
import '../../widgets/loading_indicators.dart';
import '../endpoints.dart';

class PostDeviceTokenApi {
  Future<Map> postDeviceToken(Map data) async {
    final _response = await postHttp(
      Endpoints.postDeviceToken(),
      data,
    );

    if (_response.statusCode == 200) {
      Map data = json.decode(json.encode(_response.data));
      log(data.toString());
      return data;
    }
    if (kDebugMode) {
      print(_response.toString);
    }
    Map empty = {};
    return empty;
  }
}
