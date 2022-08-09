import 'package:rxdart/rxdart.dart';
import 'api.dart';

class PostOrderStatusRX {
  final api = PostOrderStatusApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getOrderStatusData => _dataFetcher.stream;

  Future<void> postOrderStatus(String orderId, int status) async {
    try {
      Map data = {"code": orderId, "status": status};
      Map resdata = await api.postOrderStatus(data);
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
