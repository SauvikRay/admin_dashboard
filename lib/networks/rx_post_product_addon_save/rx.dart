import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '/helpers/navigation_service.dart';
import '/networks/rx_post_product_addon_save/api.dart';

import '../../widgets/loading_indicators.dart';

class PostProductAddonRX {
  final api = PostProductAddonApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getPostProductAddonData => _dataFetcher.stream;

  Future<void> postProductAddonData(
    int? foodId,
    String name,
    String price,
    File? icon,
    String description,
    int? addonId,
  ) async {
    try {
      // showDialog(
      //   context: NavigationService.context,
      //   builder: (context) => loadingIndicatorCircle(context: context),
      // );
      Map responsData = await api.postProductAddon(
          addonId, foodId, name, price, icon, description);
      _dataFetcher.sink.add(responsData);
      // NavigationService.goBack;
    } catch (e) {
      // NavigationService.goBack;
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
