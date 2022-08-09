import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../constants/app_constants.dart';
import 'api.dart';

class PostShopCustomerRangeRX {
  final api = PostShopCustomerRangeApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getPostShopHolidaysRemoveRes => _dataFetcher.stream;

  Future<void> postShopCustomerRange({
    String? range,
  }) async {
    try {
      Map data = {
        "customer_range": range,
      };
      Map resdata = await api.postShopCustomerRange(data);
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
