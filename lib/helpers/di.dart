import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

import '/helpers/table_model/addon_id.dart';
import '/helpers/table_model/order_type.dart';

import 'table_model/food_options_id.dart';
import 'table_model/order_id.dart';

final locator = GetIt.instance;

void diSetup() {
  locator.registerSingleton<OrderType>(OrderType());
  locator.registerLazySingleton(() => FirebaseMessaging.instance);
  locator.registerSingleton<FoodId>(FoodId());
  locator.registerSingleton<OrderId>(OrderId());
  locator.registerSingleton<AddonId>(AddonId());
}
