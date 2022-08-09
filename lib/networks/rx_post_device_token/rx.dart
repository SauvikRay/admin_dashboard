import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../constants/app_constants.dart';
import 'api.dart';

class PostDeviceTokenRX {
  final api = PostDeviceTokenApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getPostDeviceTokenRes => _dataFetcher.stream;

  Future<void> postDeviceToken({String? token}) async {
    try {
      GetStorage storage = GetStorage();
      Map<String, dynamic> data = {
        'user_id': storage.read(kKeyUserID),
        'device_id': storage.read(kKeyDeviceID),
        'token': token
      };
      Map resdata = await api.postDeviceToken(data);
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
