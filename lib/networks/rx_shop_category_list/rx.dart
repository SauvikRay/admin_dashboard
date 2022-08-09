import 'package:rxdart/rxdart.dart';

import 'api.dart';

class GetShopCategoryPopupListRX {
  final api = GetShopCategoryPopupListApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getShopCategoryPopupListData => _dataFetcher.stream;
  Future<void> fetchShopCategoryPopupListData() async {
    try {
      Map shopCategoryListData = await api.fetchShopCategoryPopupList();
      _dataFetcher.sink.add(shopCategoryListData);
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
