import 'package:firebase_notification/routes/routes_names.dart';
import 'package:firebase_notification/screens/forgot_password_screen/forgot_password.dart';
import 'package:firebase_notification/screens/home_screen/home.dart';
import 'package:firebase_notification/screens/login_screen/login.dart';
import 'package:firebase_notification/screens/sign_up_screen/sign_up.dart';
import 'package:firebase_notification/screens/splash_screen/splash.dart';
import 'package:firebase_notification/screens/view/noti.dart';
import 'package:flutter/material.dart';

class RoutesServices {
  static Route<dynamic> generateRoute(RouteSettings setting) {
    switch (setting.name) {
      case RoutesNames.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginView());
      case RoutesNames.signInScreen:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case RoutesNames.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeView());
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashView());
      case RoutesNames.forgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case RoutesNames.newScren:
        return MaterialPageRoute(builder: (_) => CustomScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  backgroundColor: Colors.white,
                  appBar: null,
                  body: SafeArea(
                      child: Center(
                    child: Text("No routes defined for ${setting.name}"),
                  )),
                ));
    }
  }
}
