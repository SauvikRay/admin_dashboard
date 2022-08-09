import 'package:flutter/material.dart';

class PopUpStatus extends ChangeNotifier {
  String _val = "Número da encomenda";

  String get name => _val;

  changename(String name) async {
    _val = name;
    notifyListeners();
  }
}
