import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '/widgets/loading_indicators.dart';

import '../../helpers/navigation_service.dart';
import 'api.dart';

class PostProductCategoryRX {
  final api = PostProductCategorySaveApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getFileData => _dataFetcher.stream;

  Future<void> postProductCategoryData(
      String name, String restaurantId, File? icon, String status) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );

      Map allData =
          await api.postProductCategory(name, restaurantId, icon, status);
      _dataFetcher.sink.add(allData);

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
