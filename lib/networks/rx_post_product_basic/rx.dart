import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../helpers/navigation_service.dart';
import '../../widgets/loading_indicators.dart';
import 'api.dart';

class PostProductBasicRX {
  final api = PostProductBasicApi();
  Map empty = {};
  final BehaviorSubject _dataFetcher = BehaviorSubject<Map>();
  ValueStream get getFileData => _dataFetcher.stream;
  Future<void> postProductBasicData(
      String name,
      String foodCategoryId,
      String description,
      String status,
      String shortDescription,
      String restaurantId,
      String? featuredImage,
      {String? id}) async {
    try {
      showDialog(
        context: NavigationService.context,
        builder: (context) => loadingIndicatorCircle(context: context),
      );
      Map allData = await api.postProductBasic(name, foodCategoryId,
          description, status, shortDescription, restaurantId, featuredImage,
          id: id);
      _dataFetcher.sink.add(allData);
      NavigationService.goBack;
    } catch (e) {
      NavigationService.goBack;
      _dataFetcher.sink.addError(e);
      log(e.toString());
    } finally {}
  }

  void clean() {
    _dataFetcher.sink.add(empty);
  }

  void dispose() {
    _dataFetcher.close();
  }
}
