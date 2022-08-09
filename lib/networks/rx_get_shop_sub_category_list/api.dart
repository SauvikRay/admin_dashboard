import '/helpers/dio/dio.dart';
import '/networks/endpoints.dart';
import 'dart:convert';

class GetShopSubCategoryPopupListApi {
  Future<Map> fetchShopSubCategoryPopupList(String categoriesId) async {
    final response =
        await getHttp(Endpoints.getShopSubCategoryPopUpList(categoriesId));
    if (response.statusCode == 200) {
      Map data = json.decode(json.encode(response.data));
      return data;
    }
    Map empty = {};
    return empty;
  }
}
