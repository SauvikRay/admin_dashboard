import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '/helpers/navigation_service.dart';
import '../../widgets/loading_indicators.dart';
import 'api.dart';

class GetOrdersRX {
  final api = GetOrdersApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getOrdersData => _dataFetcher.stream;

  Future<void> fetchOrderData(String status, {int? record, int? page}) async {
    try {
      Map data = await api.fetchOrdersData(status, record: record, page: page);
      _dataFetcher.sink.add(data);
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
