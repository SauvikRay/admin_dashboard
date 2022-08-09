import 'package:rxdart/rxdart.dart';
import '/networks/rx_product_category/api.dart';

class GetProductCategoryRX {
  final api = GetProductCategoryApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getProductCategoryData => _dataFetcher.stream;

  Future<void> fetchProductCategoryData(String restaurantId) async {
    try {
      Map categoryData = await api.fetchProductCategoryData(restaurantId);
      _dataFetcher.sink.add(categoryData);
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
