import 'dart:convert';
import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';

import '../../constants/app_constants.dart';

class LoginApi {
  Future<Map> login(String email, String password, String apptype) async {
    Map data = {
      "email_phone": email,
      "password": password,
      "app_type": apptype
    };

    final response = await postHttp(Endpoints.postlogin(), data);

    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));

      return data;
    }

    log(response);

    Map empty = {};
    return empty;
  }
}
