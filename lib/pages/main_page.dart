import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/services/auth_service.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final String usreId = AuthService().getCurretUser()?.uid ?? "unknown";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Main Page"),
            Text("You are now sign in"),
            const SizedBox(
              height: 30,
            ),
            Text('User ID: $usreId'),
          ],
        ),
      ),
    );
  }
}