import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../helpers/notification_service.dart';
import '../api_acess.dart';
import '/constants/app_constants.dart';
import 'api.dart';

class GetShopRX {
  final api = GetShopApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getShopData => _dataFetcher.stream;

  Future<void> fetchShopData() async {
    final storage = GetStorage();
    try {
      Map data = await api.fetcShopData();
      _dataFetcher.sink.add(data);
      if (data['data'] != null) {
        String shopID = data['data']['id'].toString();
        String shopSlug = data['data']['slug'];
        storage.write(kKeyShopID, shopID);
        storage.write(kKeyShopSlug, shopSlug);
        LocalNotificationService.getToken();
      }

      storage.writeIfNull(kKeyShopID, null);
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
