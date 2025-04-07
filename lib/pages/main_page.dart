import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';
import 'package:flutter_firebase_auth/services/auth_service.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final String usreId = AuthService().getCurretUser()?.uid ?? "unknown";
  final String userEmail = AuthService().getCurretUser()?.email ?? "no email";

  //create signout method
  void _signOut(BuildContext context) async {
    AuthService().signOut();
    //navigate to home page
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => const HomePage(),
      ),
      );
  }

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
            Text("You are now signed in"),
            const SizedBox(
              height: 30,
            ),
            Text('User ID: $usreId'),
            const SizedBox(
              height: 30,
            ),
            Text("User Email: $userEmail"),
            const SizedBox(
              height: 30,
            ),

            // sign out
            ElevatedButton(
              onPressed: () {
                _signOut(context);
              },
              child: Text("Sign out"),
            ),
          ],
        ),
      ),
    );
  }
}