import 'package:firebase_notification/firebase_services/services.dart';
import 'package:firebase_notification/routes/routes_names.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseServices services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text("L O G I N "),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(),
                ),
                controller: emailController,
              ),
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Enter your password",
                  border: OutlineInputBorder(),
                ),
                controller: passwordController,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent)),
                onPressed: () {
                  services.loginServices(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                      context: context);
                },
                child: Center(
                  child: Text("L O G I N"),
                ),
              ),
              SizedBox(height: 10),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RoutesNames.forgotPasswordScreen);
                  },
                  child: Center(
                    child: Text("F O R G O T  P A S S W O R D"),
                  )),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesNames.signInScreen);
                      },
                      child: Center(
                        child: Text("S I G N  I N"),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
