import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'api.dart';

class UpdateItemCategoryRX {
  final api = UpdateItemCategoryApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getUpdateCategoryData => _dataFetcher.stream;

  Future<void> postUpdateCategory(
    String catID,
    String catName,
    String status,
    File icon,
  ) async {
    try {
      Map<String, dynamic> data = {
        "id": catID,
        "name": catName,
        "status": status
      };
      Map resdata = await api.updateItemCategory(data, icon);
      _dataFetcher.sink.add(resdata);
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
