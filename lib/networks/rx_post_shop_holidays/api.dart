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

class PostShopHolidaysApi {
  Future<Map> postShopHolidays(Map data) async {
    showDialog(
      context: NavigationService.context,
      builder: (context) => loadingIndicatorCircle(context: context),
    );

    final _response = await postHttp(
      Endpoints.postShopHolidays(),
      data,
    );

    if (_response.statusCode == 200) {
      NavigationService.goBack;
      Map data = json.decode(json.encode(_response.data));
      log(data.toString());
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
