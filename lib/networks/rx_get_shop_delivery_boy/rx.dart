import 'package:rxdart/rxdart.dart';
import 'api.dart';

class GetShopDeliveyBoyApiRX {
  final api = GetShopDeliveyBoyApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getGetShopDeliveyBoyData => _dataFetcher.stream;

  Future<void> fetchGetShopDeliveyBoyData() async {
    try {
      Map data = await api.fetchShopDeliveyBoyList();
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
