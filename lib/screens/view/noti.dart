import 'package:firebase_notification/firebase_services/notifications_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomScreen extends StatefulWidget {
  const CustomScreen({super.key});

  @override
  State<CustomScreen> createState() => _CustomScreenState();
}

class _CustomScreenState extends State<CustomScreen> {
  NotificationsServices services = NotificationsServices();
  @override
  void initState() {
    services.requstPermission();
    services.getDeviceToken().then((value){
      if (kDebugMode) {
        print("Device Token: $value");
      }
    });
    services.isTokenFresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("PUSH NOTIFICATION"),
          ),
        ),
        body: Center(
          child: Text("Welcome to Push Notification"),
        ),
      ),
    );
  }
}
