import 'package:rxdart/rxdart.dart';
import 'api.dart';

class GetBalanceRecRX {
  final api = GetBalanceRecApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getBalanceRecData => _dataFetcher.stream;

  Future<void> fetchBalanceRecData({int? record, int? page}) async {
    try {
      Map data = await api.fetchBalanceRecData(record: record, page: page);
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
