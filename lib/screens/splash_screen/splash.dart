import 'package:firebase_notification/firebase_services/services.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  FirebaseServices services = FirebaseServices();
  @override
  void initState() {
    services.splashServices(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
          child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )),
    );
  }
}
