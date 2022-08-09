import 'package:rxdart/rxdart.dart';
import 'api.dart';

class GetDeliveyBoyRX {
  final api = GetDeliveyBoyApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getGetDeliveyBoyData => _dataFetcher.stream;

  Future<void> fetchGetDeliveyBoyData() async {
    try {
      Map data = await api.fetchDeliveyBoyList();
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
