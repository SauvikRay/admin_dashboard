import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '/constants/app_constants.dart';
import 'api.dart';

class GetShopListRX {
  final api = GetShopListApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getShopListData => _dataFetcher.stream;

  Future<void> fetchShopListData() async {
    try {
      Map data = await api.fetcShopListData();
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
