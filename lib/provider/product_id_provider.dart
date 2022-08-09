import 'package:flutter/material.dart';

class ProductIdProvider extends ChangeNotifier {
  String _id = '';
  String get id => _id;
  changeId(String id) {
    _id = id;
    notifyListeners();
  }
}
