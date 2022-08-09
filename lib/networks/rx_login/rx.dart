import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '/helpers/all_routes.dart';

import '../../constants/app_constants.dart';
import '../../helpers/dio/dio.dart';
import '../../helpers/navigation_service.dart';
import '../../helpers/notification_service.dart';
import '../../widgets/loading_indicators.dart';
import 'api.dart';

class GetLoginRX {
  final api = LoginApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getFileData => _dataFetcher.stream;
  String message = "";
  Future<void> login(
    String email,
    String password,
  ) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map data = await api.login(email, password, 'shop_owner');
      _dataFetcher.sink.add(data);
      final storage = GetStorage();
      message = data["message"];
      String accesstoken = data['data']['access_token'];
      String phone = data['data']['user']['phone'];
      String firstName = data['data']['user']['first_name'];
      String lastName = data['data']['user']['last_name'];
      String id = data['data']['user']['id'].toString();
      String user = data['data']['user']['email'];

      storage.write(kKeyIsLoggedIn, true);
      storage.write(kKeyAccessToken, accesstoken);
      storage.write(kPhone, phone);
      storage.write(kKeyFirstName, firstName);
      storage.write(kKeyLastName, lastName);
      storage.write(kKeyUserID, id);
      storage.write(kKeyUser, user);

      DioSingleton.instance.update(accesstoken);
      LocalNotificationService.getToken();
      NavigationService.goBack;

      NavigationService.navigateToReplacement(Routes.loadingScreen);
    } catch (e) {
      log(e.toString());
      NavigationService.goBack;
      _dataFetcher.sink.addError(e);
    } finally {
      ScaffoldMessenger.of(NavigationService.context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }

  void clean() {
    _dataFetcher.sink.add(empty);
  }

  void dispose() {
    _dataFetcher.close();
  }
}
