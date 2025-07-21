import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notification/routes/routes_names.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  //splash screen
  void splashServices(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = auth.currentUser;
      if (user != null) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamed(context, RoutesNames.homeScreen);
        });
      } else {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamed(context, RoutesNames.signInScreen);
        });
      }
    });
  }

  //Login screen
  void loginServices(
      {required String email,
      required String password,
      required BuildContext context}) {
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
        Navigator.pushNamed(context, RoutesNames.homeScreen);
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

  //sign up services
  void signInServices(
      {required String email,
      required String password,
      required BuildContext context}) {
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
        Navigator.pushNamed(context, RoutesNames.loginScreen);
      });
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        showCloseIcon: true,
        duration: Duration(seconds: 20),
        content: Text(
          "$error\n$stackTrace",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ));
    });
  }

  //Sign out services
  void signOutServices(BuildContext context) {
    auth.signOut().then((value) {
      Navigator.pushNamed(context, RoutesNames.loginScreen);
    });
  }

  //Forgot password services
  void forgotPasswordServices(BuildContext context, {required String email}) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue,
          content: Text(
            "Code has sent to your email $email.",
            style: TextStyle(color: Colors.white),
          )));
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            error.toString(),
            style: TextStyle(color: Colors.white),
          )));
    });
  }
}
