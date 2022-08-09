import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../constants/app_constants.dart';
import 'api.dart';

class PostShopHolidaysRX {
  final api = PostShopHolidaysApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getPostShopHolidaysRes => _dataFetcher.stream;

  Future<void> postShopHolidays({
    String? holidays,
  }) async {
    final storage = GetStorage();
    String shopID = storage.read(kKeyShopID);
    try {
      Map data = {
        "restaurant_id": shopID,
        "holidays": holidays,
      };
      Map resdata = await api.postShopHolidays(data);
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
