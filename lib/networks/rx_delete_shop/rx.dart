// import 'dart:io';

// import 'package:contesta_na_hora/helpers/navigation_service.dart';
// import 'package:contesta_na_hora/widgets/loading_indicators.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
// import '../../helpers/all_routes.dart';
// import '../../helpers/navigation_service.dart';
// import '../../screens/contestar_submit_screen.dart';
// import 'api.dart';

import 'package:rxdart/rxdart.dart';
import '/networks/rx_get_holidaysList/api.dart';
import '/networks/rx_get_itemlist/api.dart';

import 'api.dart';

class DeleteShopRX {
  final api = DeleteShopApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getDeleteShopResdata => _dataFetcher.stream;

  Future<void> deleteShopData() async {
    try {
      Map data = await api.deleteShop();
      _dataFetcher.sink.add(data);
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
