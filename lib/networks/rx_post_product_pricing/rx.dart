import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../helpers/navigation_service.dart';
import '../../widgets/loading_indicators.dart';
import 'api.dart';

class PostProductPriceRX {
  final api = PostProductPriceApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getFileData => _dataFetcher.stream;
  Future<void> postProductPriceData(String name, String price, int isDefault,
      String description, int restaurantFoodId,
      {int? optionId}) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map allData = await api.postProductPrice(
          name, price, isDefault, description, restaurantFoodId,
          optionId: optionId);
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
