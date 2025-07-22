import 'package:firebase_notification/firebase_services/services.dart';
import 'package:firebase_notification/routes/routes_names.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool isLoadings = false;
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text("S I G N  U P "),
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
                  setState(() {
                    isLoadings = true;
                  });
                  services.signInServices(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                      context: context);
                  setState(() {
                    isLoadings = false;
                  });
                },
                child: Center(
                  child: isLoadings
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("S I G N  U P"),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(Colors.blueAccent)),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await FirebaseServices().loginWithGoogle(context);
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Center(
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text("S I G N  U P  W I T H  G O O G L E"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RoutesNames.loginScreen);
                      },
                      child: Center(
                        child: Text("L O G I N"),
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
