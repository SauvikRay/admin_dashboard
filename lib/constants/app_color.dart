import 'dart:core';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // static const Color allPrimaryColor = Color(0xFFF9500A);

  static const Color scaffoldColor = Color(0xFFFBFBFB);
  static const Color primaryColor = Color(0xFFF9500A);

  static const Color headLine1Color = Color(0xFF4A4A4A);
  static const Color headLine2Color = Color(0xFF2C303E);
  static const Color disabledColor = Color(0xFF9B9B9B);
  static const Color unselectedButtonTextColor = Color(0xFF2C303E);

  static const Color creditHighliteColor = Color(0xFF709B72);
  static const Color debitHighliteColor = Color(0xFFEA0606);

  static const Color penIconColor = Color(0xFF00A7FF);
  static const Color alertButtonColor = Color(0xFFFEFFFB);
  static const Color activeColor = Color(0xFF709B72);
  static const Color inactiveColor = Color(0xFFFBC45E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color borderColor = Color(0xFFDDDDDD);

  static const Color secondaryColor = Color(0xFF444242);

  // static const Color expandedList = Color(0xFFECECEC);
  static const Color shadowText = Color(0xFFF1F2F7);
  static const Color shadowText2 = Color(0xFFB0B0B0);
  // static const Color linkColor = Color(0xFF989BA5);
  // static const Color appDrawerTextColor = Color(0xFF4D4D4D);
  // static const Color publicationTextColor = Color(0xFF3B566E);
  // static const Color loaderColor = Color(0xFFD8D8D8);
  // static const Color bookNameColor = Color(0xFFD8D8D8);
  // static const Color tudoColor = Color(0xFFDEAB52);
  // static const Color dateColor = Color(0xFF979797);
  // static const Color beginGradient = Color(0xFFA48F73);
  // static const Color endGradient = Color(0xFF887357);
  // static const Color buttonColor = Color.fromARGB(255, 240, 158, 50);
  // static const Color deviderColor = Color.fromARGB(255, 93, 155, 139);
  // static const Color textFieldBorderColor = Color(0xFFE5E5E5);
  // static const Color expandedTilebgColor = Colors.white;
  // static const Color drawerLogoColor = Color(0xFFC68A39);
  // static const Color drawerLineColor = Color(0xFFEDF5F3);

  static const MaterialColor kToDark = MaterialColor(
    0xFFF9500A, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFF9500A), //10%
      100: Color(0xFFF9500A), //20%
      200: Color(0xFFF9500A), //30%
      300: Color(0xFFF9500A), //40%
      400: Color(0xFFF9500A), //50%
      500: Color(0xFFF9500A), //60%
      600: Color(0xFFF9500A), //70%
      700: Color(0xFFF9500A), //80%
      800: Color(0xFFF9500A), //80%
      900: Color(0xFFF9500A), //80%
    },
  );
}

class OrderStatusColor {
  //Order Status Color Code
  static const Color kPENDING = Color(0xFF6c757d);
  static const Color kACCEPTED = Color(0xFF0b79fa);
  static const Color kFOODPROCESSING = Color(0xFF31a2b8);
  static const Color kFOODREADY = Color(0xFFffc234);
  static const Color kFOODPICKED = Color(0xFF6658dd);
  static const Color kFOODDELIVERED = Color(0xFF4fa744);
  static const Color kCANCELLED = Color(0xFFdd4246);
  static const Color kREJECTEDBYSHOP = Color(0xFFdd4246);
  static const Color kFAILED = Color(0xFFdd4246);
}

class DeliveryStatusColor {
  //Delivery Status Color Code
  static const Color kPENDING = Color(0xFF6c757d);
  static const Color kDELIVERYMANCONFIRMED = Color(0xFF0b79fa);
  static const Color kDELIVERYSTARTED = Color(0xFF6658dd);
  static const Color kARRIVEDATSHOP = Color(0xFFffc234);
  static const Color kONTRANSIT = Color(0xFF31a2b8);
  static const Color kDELIVERED = Color(0xFF4fa744);
}
