// ignore_for_file: non_constant_identifier_names

import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:rxdart/rxdart.dart';
import '../../constants/app_constants.dart';
import 'api.dart';

class PostShopScheduleRX {
  final api = PostShopScheduleApi();
  late Map empty;
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();

  ValueStream get getPostShopScheduleRes => _dataFetcher.stream;

  Future<void> postShopSchedule({
    String? weekend_Sunday,
    String? day_opening_Sunday,
    String? day_break_start_Sunday,
    String? day_break_end_Sunday,
    String? day_closing_Sunday,
    String? weekend_Monday,
    String? day_opening_Monday,
    String? day_break_start_Monday,
    String? day_break_end_Monday,
    String? day_closing_Monday,
    String? weekend_Tuesday,
    String? day_opening_Tuesday,
    String? day_break_start_Tuesday,
    String? day_break_end_Tuesday,
    String? day_closing_Tuesday,
    String? weekend_Wednesday,
    String? day_opening_Wednesday,
    String? day_break_start_Wednesday,
    String? day_break_end_Wednesday,
    String? day_closing_Wednesday,
    String? weekend_Thursday,
    String? day_opening_Thursday,
    String? day_break_start_Thursday,
    String? day_break_end_Thursday,
    String? day_closing_Thursday,
    String? weekend_Friday,
    String? day_opening_Friday,
    String? day_break_start_Friday,
    String? day_break_end_Friday,
    String? day_closing_Friday,
    String? weekend_Saturday,
    String? day_opening_Saturday,
    String? day_break_start_Saturday,
    String? day_break_end_Saturday,
    String? day_closing_Saturday,
  }) async {
    try {
      final storage = GetStorage();
      String shopID = storage.read(kKeyShopID);
      Map data = {
        "restaurant_id": shopID,
        "weekend_Sunday": weekend_Sunday,
        "day_opening_Sunday": day_opening_Sunday,
        "day_break_start_Sunday": day_break_start_Sunday,
        "day_break_end_Sunday": day_break_end_Sunday,
        "day_closing_Sunday": day_closing_Sunday,
        "weekend_Monday": weekend_Monday,
        "day_opening_Monday": day_opening_Monday,
        "day_break_start_Monday": day_break_start_Monday,
        "day_break_end_Monday": day_break_end_Monday,
        "day_closing_Monday": day_closing_Monday,
        "weekend_Tuesday": weekend_Tuesday,
        "day_opening_Tuesday": day_opening_Tuesday,
        "day_break_start_Tuesday": day_break_start_Tuesday,
        "day_break_end_Tuesday": day_break_end_Tuesday,
        "day_closing_Tuesday": day_closing_Tuesday,
        "weekend_Wednesday": weekend_Wednesday,
        "day_opening_Wednesday": day_opening_Wednesday,
        "day_break_start_Wednesday": day_break_start_Wednesday,
        "day_break_end_Wednesday": day_break_end_Wednesday,
        "day_closing_Wednesday": day_closing_Wednesday,
        "weekend_Thursday": weekend_Thursday,
        "day_opening_Thursday": day_opening_Thursday,
        "day_break_start_Thursday": day_break_start_Thursday,
        "day_break_end_Thursday": day_break_end_Thursday,
        "day_closing_Thursday": day_closing_Thursday,
        "weekend_Friday": weekend_Friday,
        "day_opening_Friday": day_opening_Friday,
        "day_break_start_Friday": day_break_start_Friday,
        "day_break_end_Friday": day_break_end_Friday,
        "day_closing_Friday": day_closing_Friday,
        "weekend_Saturday": weekend_Saturday,
        "day_opening_Saturday": day_opening_Saturday,
        "day_break_start_Saturday": day_break_start_Saturday,
        "day_break_end_Saturday": day_break_end_Saturday,
        "day_closing_Saturday": day_closing_Saturday
      };
      log(data.toString());
      Map resdata = await api.postShopSchedule(data);
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
