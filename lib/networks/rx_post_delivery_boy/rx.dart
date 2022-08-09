import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wede_restaurant/constants/app_constants.dart';
import 'api.dart';

class PostDeliveyBoyListRX {
  final api = PostDeliveyBoyListApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getPostDeliveyBoyListApiData => _dataFetcher.stream;

  Future<void> postDeliveyBoyList(List deliveryManIds) async {
    try {
      final storage = GetStorage();
      String shoSlug = storage.read(kKeyShopSlug);
      Map data = {"slug": shoSlug, "user_ids": deliveryManIds};
      Map resdata = await api.postDelieveryListBoy(data);
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
