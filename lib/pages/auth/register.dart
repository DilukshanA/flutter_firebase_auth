import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/pages/auth/login.dart';
import 'package:flutter_firebase_auth/pages/main_page.dart';
import 'package:flutter_firebase_auth/services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscurePassword = true;
   bool _obscureConfirmPassword = true;

  //register method
  Future<void> _registerUser() async {
    if(!_formkey.currentState!.validate()){
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try{
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      if(password != confirmPassword){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Password do not match"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              )
            ],
          )
        );

        return;
      }

      await AuthService().registerNewUser(email: email, password: password);
      // navigate to home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    } catch(error) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            content: const Text("Error registering user"),
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
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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

              // create a text field for confirm password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      _obscureConfirmPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                    )
                  )
                ),
                validator: (value) {
                  if(value == null || value.isEmpty){
                    return "Please confirm your password";
                  } else if(value != _passwordController.text){
                    return "Password do not match";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // create register button
              ElevatedButton(
                onPressed: _registerUser,
                child: _isLoading
                ? const CircularProgressIndicator()
                : const Text("Resister"),
              ),

              const SizedBox(height: 20),

              // create a text button for login
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    )
                  );
                },
                child: const Text('Already have an account? Login here',
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