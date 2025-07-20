import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notification/screens/home_screen/home.dart';
import 'package:firebase_notification/screens/login_screen/login.dart';
import 'package:firebase_notification/screens/sign_up_screen/sign_up.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  // For splash screen
  void splashServices(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeView()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUpView()));
    }
  }

  // For Login screen
  void loginServices(
      {required String email,
      required String password,
      required BuildContext context}) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Login Successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeView()));
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    });
  }

  // For sign up services
  void signInServices(
      {required String email,
      required String password,
      required BuildContext context}) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Account Created successfully",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginView()));
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          "Account not created ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    });
  }
}
