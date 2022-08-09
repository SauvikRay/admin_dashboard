import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '/networks/api_acess.dart';
import '/networks/rx_post_shop_basic/api.dart';
import '/networks/rx_product_category_save/api.dart';

import '/widgets/loading_indicators.dart';

import '../../constants/app_constants.dart';
import '../../helpers/navigation_service.dart';

class PostSaveShopBasicRX {
  final api = PostSaveShopBasicApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getFormFileData => _dataFetcher.stream;

  Future<void> postSaveShopBasicData(
    String name,
    String restaurantGroupId,
    String userId,
    String restaurantCategoryId,
    List<String> subCategoryIds,
    String iban,
    String nif,
    String shortDescription,
    String description, {
    String? status,
    String? id,
    File? featuredImage,
  }) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );

      Map data = await api.postSaveShopBasic(
        name,
        restaurantGroupId,
        userId,
        restaurantCategoryId,
        subCategoryIds,
        iban,
        nif,
        shortDescription,
        description,
        status: status,
        featuredImage: featuredImage,
        id: id,
      );
      log(data.toString());
      _dataFetcher.sink.add(data);
      await getShopRXobj.fetchShopData();
      NavigationService.goBack;
    } catch (e) {
      NavigationService.goBack;
      _dataFetcher.sink.addError(e);
      log(e.toString());
    } finally {}
  }

  void clean() {
    _dataFetcher.sink.add(empty);
  }

  void dispose() {
    _dataFetcher.close();
  }
}
