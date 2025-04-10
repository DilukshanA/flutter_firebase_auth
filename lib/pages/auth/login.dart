import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/auth/forgot_password_page.dart';
import 'package:flutter_firebase_auth/pages/auth/register.dart';
import 'package:flutter_firebase_auth/pages/main_page.dart';
import 'package:flutter_firebase_auth/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscurePassword = true;

  //sign in user method
  Future<void> _signInUser() async {
    if(!_formkey.currentState!.validate()){
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try{
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      await AuthService().signInUser(email: email, password: password);

      // navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } catch(error){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text('Error signing user : $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: const Text("OK"),
              )
            ],
          )
        );
    }
  }

  // sign in with google method
  Future<void> _signInWithGoogle() async {

    setState(() {
      _isLoading = true;
    });

    try{
      await AuthService().signInWithGoogle();

      // navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } catch(error){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: Text('Error sign in with Google : $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: const Text("OK"),
              )
            ],
          )
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              // create a text field for email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email"
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please enter an email";
                  } else if(!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)){
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),

              // create a text field for password
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                    )
                  )
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please enter a password";
                  } else if(value.length < 6){
                    return "Password must be at least 6 characters long";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // create login button
              ElevatedButton(
                onPressed: _signInUser,
                child: _isLoading
                ? const CircularProgressIndicator()
                : const Text("Login"),
              ),

              const SizedBox(height: 20),

              //create button for google sign in
              ElevatedButton(
                onPressed: _signInWithGoogle,
                child: _isLoading
                ? const CircularProgressIndicator()
                : const Text("Sign in with Google")
              ),          

              const SizedBox(height: 20),

              // create a text button for forgot password
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordPage(),
                    )
                  );
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // create a text button for register
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    )
                  );
                },
                child: const Text('Don\'t have an account? Register here',
                style: TextStyle(
                  color: Colors.blue,
                ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}