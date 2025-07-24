import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/firebase_options.dart';
import 'package:firebase_notification/routes/routes_names.dart';
import 'package:firebase_notification/routes/routes_services.dart';
import 'package:firebase_notification/screens/view/noti.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingHandler);
  runApp(const CustomScreen());
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: RoutesNames.splashScreen,
      onGenerateRoute: RoutesServices.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
