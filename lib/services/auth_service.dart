import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/exceptions/auth_exceptions.dart';

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

  //sign in anonymously with auth exceptions
  Future<void>signInAnonymouslyWithExceptions() async {
    try{
      final UserCredential userCredential =  await _auth.signInAnonymously();
      final user = userCredential.user;
      
      if(user != null){
        print("Signed in Anonymously with uid: ${user.uid}");
      }
    }
    
    on FirebaseAuthException catch(error){
      print("Error sign in Anonymously: ${mapFirebaseAuthExceptionCode(error.code)}");
      throw Exception(mapFirebaseAuthExceptionCode(error.code));
    }
    
    catch(error){
      print("An unexpected error occurred: $error");
    }
  }

  //get current user
  User? getCurretUser(){
    return _auth.currentUser;
  }
}


