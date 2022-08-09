import 'package:rxdart/rxdart.dart';

import 'api.dart';

class GetShopSubCategoryPopUpListRX {
  final api = GetShopSubCategoryPopupListApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getShopSubCategoryPopupListData => _dataFetcher.stream;
  Future<void> fetchSubCategoryData(String categoriesId) async {
    try {
      Map subCategoryData = await api.fetchShopSubCategoryPopupList(categoriesId);
      _dataFetcher.sink.add(subCategoryData);
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
