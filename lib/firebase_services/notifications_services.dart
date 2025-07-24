import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsServices {
  // Initialize firebase message plugin
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void requestNotificationPermission() async {
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
      if (kDebugMode) {
        print("Event: $event");
      }
    });
  }

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

// Method to initialze flutter local notification plugin to show notificaion for android when app is active.
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings("@mipmap/ic_launcher");
    var isoInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: isoInitializationSettings,
    );

    await plugin.initialize(initializationSetting,
        onDidReceiveNotificationResponse: (details) {
      // When app is active for android, handle interaction
      handleMessage(context, message);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {}

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      showNotification(message);
      if (kDebugMode) {
        print("notifications title: ${notification!.title.toString()}");
        print("Notification body: ${notification.body.toString()}");
        print("Count: ${android!.count.toString()}");
        print("Data:${message.data.toString()}");
      }
    });
  }

  // Function to show visible notification when app is active
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        importance: Importance.max,
        message.notification!.android!.channelId.toString(),
        message.notification!.android!.channelId.toString());
    // Android Notification details
    AndroidNotificationDetails andriodNotification = AndroidNotificationDetails(
        channel.id.toString(), channel.name.toString());
    // IOS Notification details
    DarwinNotificationDetails iosNotification = DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
      android: andriodNotification,
      iOS: iosNotification,
    );

    Future.delayed(Duration.zero, () {
      plugin.show(0, message.notification!.title.toString(),
          message.notification!.body.toString(), notificationDetails);
    });
  }
}
