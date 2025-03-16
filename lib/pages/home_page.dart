import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/auth/anonymous.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AnonymousLoginPage(),
    );
  }
}