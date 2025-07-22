import 'package:firebase_notification/firebase_services/services.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController emailController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FirebaseServices firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("F O R G O T  P A S S W O R D"),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          children: [
            SizedBox(height: 30),
            TextFormField(
              focusNode: focusNode,
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter yuur email",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.blueAccent),
                  foregroundColor: WidgetStatePropertyAll(Colors.white)),
              onPressed: () {
                focusNode.unfocus();
                setState(() {
                  firebaseServices.forgotPasswordServices(
                    context,
                    email: emailController.text.trim(),
                  );
                });
              },
              child: Center(
                child: Text("R E S E T  P A S S W O R D"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
