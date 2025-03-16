import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/main_page.dart';
import 'package:flutter_firebase_auth/services/auth_service.dart';

class AnonymousLoginPage extends StatelessWidget {
  const AnonymousLoginPage({super.key});

  void _signInAnonymously(BuildContext context) async{
    try{
      await AuthService().signInAnonymously();

      //navigate to main page
      if(context.mounted){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
        );
      }

    }
    catch(error){
      print("Error sign in Anonymously: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase annonymous login"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInAnonymously(context),
          child: const Text("Sign in Anonymously"),),
      ),
    );
  }
}