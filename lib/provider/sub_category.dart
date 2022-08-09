import 'package:flutter/material.dart';

import '../screens/tabs/button_pen_nome.dart';

class SubCategory extends ChangeNotifier {
  List<Animal>? selectedAnimals = [];

  clearSubcat() {
    selectedAnimals = [];
    notifyListeners();
  }
}
