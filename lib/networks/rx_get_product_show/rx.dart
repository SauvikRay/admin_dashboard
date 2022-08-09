import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import 'api.dart';

class GetProductShowRx {
  final api = GetProductShowApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getProductShowData => _dataFetcher.stream;

  Future<void> fetchProductShowData(String foodId) async {
    try {
      Map productData = await api.fetchProductShow(foodId);
      log(productData.toString());
      _dataFetcher.sink.add(productData);
    } catch (e) {
      _dataFetcher.sink.addError(e);
    }
  }

  void clean() {
    _dataFetcher.sink.add(empty);
  }

  void dispose() {
    _dataFetcher.close();
  }
}
