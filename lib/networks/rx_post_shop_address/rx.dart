import 'package:rxdart/rxdart.dart';
import 'api.dart';

class PostShopAddressRX {
  final api = PostShopAddressApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getPostShopAddressRes => _dataFetcher.stream;

  Future<void> postShopAddress(
      {String? lat,
      String? long,
      String? phone,
      String? countyCode,
      String? countyPhone,
      String? email,
      String? address,
      String? city,
      String? postalcode}) async {
    try {
      Map data = {
        "phone": phone,
        "email": email,
        "country_code": countyCode,
        "country_phone": countyPhone,
        "address": address,
        "latitude": lat,
        "longitude": long,
        "city": city,
        "postal_code": postalcode
      };
      Map resdata = await api.postShopAddress(data);
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
