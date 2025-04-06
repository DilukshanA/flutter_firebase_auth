import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/auth/register.dart';
import 'package:flutter_firebase_auth/pages/main_page.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          // whiel waiting for authentication state
          return const Center(child: CircularProgressIndicator());
        } else if(snapshot.hasData){
          // user is signed in
          return MainPage();
        } else{
          // user is not signed in
          return const RegisterPage();
        }
      }
    );
  }
}