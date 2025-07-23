import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationsServices {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void requstPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      carPlay: true,
      badge: true,
      criticalAlert: true,
      sound: true,
      provisional: true,
    );
    if (kDebugMode) {
      print(settings);
    }

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print("Permission granted");
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print("Provisional granted");
      }
    } else {
      AppSettings.openAppSettings();
      if (kDebugMode) {
        print("Denied");
      }
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await firebaseMessaging.getToken();
    return token!;
  }

  void isTokenFresh() async {
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      print("Event: $event");
    });
  }
}
