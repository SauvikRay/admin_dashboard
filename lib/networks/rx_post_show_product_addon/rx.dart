import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../helpers/navigation_service.dart';
import '../../widgets/loading_indicators.dart';
import 'api.dart';

class ShowPostProductAddonRx {
  final api = ShowPostProductAddonApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getShowPostProductAddonData => _dataFetcher.stream;

  Future<void> fetchShowPostProductAddon(String foodId,
      {int? record, int? page}) async {
    try {
      // showDialog(
      //   context: NavigationService.context,
      //   builder: (context) => loadingIndicatorCircle(context: context),
      // );
      Map data =
          await api.showPostProductaddon(foodId, record: record, page: page);
      _dataFetcher.sink.add(data);
      // NavigationService.goBack;
    } catch (e) {
      // NavigationService.goBack;
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
