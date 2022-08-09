import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../constants/app_constants.dart';
import 'api.dart';

class PostShopHolidaysRemoveRX {
  final api = PostShopHolidaysRemoveApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getPostShopHolidaysRemoveRes => _dataFetcher.stream;

  Future<void> postShopHolidaysRemove({
    String? holiday,
  }) async {
    final storage = GetStorage();
    String shopID = storage.read(kKeyShopID);
    try {
      Map data = {
        "id": shopID,
        "data": holiday,
      };
      Map resdata = await api.postShopHolidaysRemove(data);
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
