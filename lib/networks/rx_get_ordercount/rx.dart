import 'package:rxdart/rxdart.dart';
import 'api.dart';

class GetOrderCountRX {
  final api = GetOrderCountApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getOrderCountData => _dataFetcher.stream;

  Future<void> fetchOrderCountData() async {
    try {
      Map data = await api.fetchOrderCountData();
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
