import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../helpers/dio/dio.dart';
import '../../helpers/navigation_service.dart';
import '../../widgets/loading_indicators.dart';
import '../endpoints.dart';

class PostOrderStatusApi {
  Future<Map> postOrderStatus(Map data) async {
    showDialog(
      context: NavigationService.context,
      builder: (context) => loadingIndicatorCircle(context: context),
    );

    final _response = await postHttp(
      Endpoints.postOrderStatus(),
      data,
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
