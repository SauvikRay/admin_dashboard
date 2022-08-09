import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../navigation_service.dart';

class Logger extends Interceptor {
  SnackBar snackBar = const SnackBar(
    content: Text("Some Thing Went Wrong"),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print("= = = Dio Request = = =");
      print(options.headers);
      print(options.data);
      print(options.contentType);
      print(options.extra);
      print("${options.baseUrl}${options.path}");
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print("= = = Dio Success Response = = =");
      print(json.encode(response.data));
      print(response.headers);
      print(response.extra);
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print("= = = Dio Error Response = = =");
      print('Error Response: ${err.response}');
      print('Error Message: ${err.message}');
      print('Error Type: ${err.type}');
      print('Error: ${err.error}');
      print('Error Req option: ${err.requestOptions}');
    }
    try {
      Map map = json.decode(err.response.toString())['errors'];
      List list = map.values.toList().first;
      //NavigationService.goBack;
      snackBar = SnackBar(
        content: Text(list[0]),
      );
    } catch (e) {
      String text = json.decode(err.response.toString())['message'];
      // List list = map.values.toList().first;
      // NavigationService.goBack;
      snackBar = SnackBar(
        content: Text(text),
      );
    } finally {
      if (kDebugMode) {
        ScaffoldMessenger.of(NavigationService.context).showSnackBar(snackBar);
      }

      // NavigationService.goBack;
    }
    return super.onError(err, handler);
  }
}
