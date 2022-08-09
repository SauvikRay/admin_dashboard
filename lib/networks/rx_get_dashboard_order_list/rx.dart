import 'package:rxdart/rxdart.dart';
import 'api.dart';

class GetDashBoardOrderListRX {
  final api = GetDashOrderListApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getDashBoardOrderListData => _dataFetcher.stream;

  Future<void> fetchDashBoardOrderListData({int? record, int? page}) async {
    try {
      Map faqData =
          await api.fetchDashBoardOrderListData(record: record, page: page);
      _dataFetcher.sink.add(faqData);
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
