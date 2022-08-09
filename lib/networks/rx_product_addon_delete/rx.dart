import 'package:rxdart/rxdart.dart';

import 'api.dart';

class ProductAddOnDeleteRx {
  final api = DeleteProductAddonApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getProductDeleteData => _dataFetcher.stream;

  Future<void> deleteProductAddon(String addonId) async {
    try {
      Map data = await api.deleteProductAddon(addonId);
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
