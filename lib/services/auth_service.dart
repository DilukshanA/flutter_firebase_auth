import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //create instance for firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anonymously
  Future <void> signInAnonymously() async {
    try{
      final UserCredential userCredential =  await _auth.signInAnonymously();
      final user = userCredential.user;
      
      if(user != null){
        print("Signed in Anonymously with uid: ${user.uid}");
      }
    } catch(error){
      print("Error sign in Anonymously: $error");
    }
  }

  //get current user
  User? getCurretUser(){
    return _auth.currentUser;
  }
}


