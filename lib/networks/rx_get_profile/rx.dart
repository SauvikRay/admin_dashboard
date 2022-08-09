import 'package:rxdart/rxdart.dart';
import 'api.dart';

class GetOrderDetailsRX {
  final api = GetOrderDetailsApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getOrderDetailsData => _dataFetcher.stream;

  Future<void> fetchOrderDetailsData(String orderID) async {
    try {
      Map data = await api.getOrderDetailsData(orderID);
      _dataFetcher.sink.add(data);
    } catch (e) {
      // print(e);
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
