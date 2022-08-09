import 'dart:convert';

import '../../helpers/dio/dio.dart';
import '../endpoints.dart';

class GetLogOutApi {
  Future<Map> fetchLogoutData() async {
    final _response = await getHttp(
      Endpoints.getLogout(),
    );

    if (_response.statusCode == 200) {
      Map data = json.decode(json.encode(_response.data));
      return data;
    }
    // print(_response.toString);
    Map empty = {};
    return empty;
  }
}
