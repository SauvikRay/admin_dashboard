import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

urlLunch(String url) {
  if (Platform.isIOS) {
    launch(url, forceSafariVC: false);
  } else {
    launch(url, forceWebView: false);
  }
}




  // Future<void> makePhoneCall(String phoneNumber) async {
  //   // Use `Uri` to ensure that `phoneNumber` is properly URL-encoded.
  //   // Just using 'tel:$phoneNumber' would create invalid URLs in some cases,
  //   // such as spaces in the input, which would cause `launch` to fail on some
  //   // platforms.
  //   final Uri launchUri = Uri(
  //     scheme: 'tel',
  //     path: phoneNumber,
  //   );
  //   await launch(launchUri.toString());
  // }