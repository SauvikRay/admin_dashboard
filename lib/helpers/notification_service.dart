import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../networks/api_acess.dart';
import 'di.dart';
import 'table_model/order_type.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final FirebaseMessaging _firebaseMessaging =
      locator<FirebaseMessaging>();

  static void initialize() {
    // initializationSettings  for Android
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: IOSInitializationSettings(),
    );

    if (Platform.isIOS) {
      _firebaseMessaging.requestPermission();
      _firebaseMessaging.getNotificationSettings();
    }
    // 1. This method only call when App is terminated(closed)
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        if (message != null) {}
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        if (message.notification != null) {
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        OrderType order = locator<OrderType>();
        getOrdersRXobj.fetchOrderData(
          order.getorderStaus,
        );
      },
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? url) async {
        OrderType order = locator<OrderType>();
        getOrdersRXobj.fetchOrderData(
          order.getorderStaus,
        );
//do navigation
      },
    );
  }

  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "dorsia",
          "dorsiapushnotificationappchannel",
          importance: Importance.max,
          priority: Priority.high,
          color: Colors.black,
        ),
      );

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data['url'],
      );
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  static Future<void> getToken() async {
    _firebaseMessaging.getToken().then((token) async {
      log('[FCM]--> token: [ $token ]');
      await sendToken(token!);
    });

    _firebaseMessaging.onTokenRefresh.listen((token) async {
      log('[FCM]--> token: [ $token ]');
      await sendToken(token);
    });
  }

  static Future<void> sendToken(String token) async {
    try {
      postDeviceTokenRXobj.postDeviceToken(token: token);
    } catch (error) {
      rethrow;
    }
  }
}
