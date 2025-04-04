import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/exceptions/auth_exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  //create instance for firebase authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create instance for google sign in
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
    // exception handling
    on FirebaseAuthException catch(error){
      print("Error sign in Anonymously: ${mapFirebaseAuthExceptionCode(errorCode : error.code)}");
      throw Exception(mapFirebaseAuthExceptionCode(errorCode : error.code));
    }
    
    catch(error){
      print("An unexpected error occurred: $error");
    }
  }

  //sign out
  Future<void> signOut() async {
    try{
      await _auth.signOut();
      print("Signed out");
    }

    // exception handling
    on FirebaseAuthException catch(error){
      print("Error sign out ${mapFirebaseAuthExceptionCode(errorCode : error.code)}");
      throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
    }

     catch(error){
      print("Error sign out: $error");
    }
  }

  //get current user
  User? getCurretUser(){
    return _auth.currentUser;
  }

  // create user with email and password
  Future<void> registerNewUser({required String email, required String password}) async{
    try{
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

    }

    // exception handling
    on FirebaseAuthException catch(error){
      print("Error creating user: ${mapFirebaseAuthExceptionCode(errorCode : error.code)}");
      throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
    }
    
    catch(error){
      print("Error creating user: $error");
    }
  }

  //sign in with email and password
  Future<void> signInUser({ required String email, required String password}) async {
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }

    // exception handling
    on FirebaseAuthException catch(error){
      print("Error signing in user: ${mapFirebaseAuthExceptionCode(errorCode : error.code)}");
      throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
    }
    
    catch(error){
      print("Error signing in user: $error");
    }
  }

  //sign in with google
  Future<void> signInWithGoogle() async {
    try{
      // trigger the google sign in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser == null){
        return;
      }
      // obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      //create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      //sign in to firebase with the google credential
      await _auth.signInWithCredential(credential);
    }

    // exception handling
    on FirebaseAuthException catch(error){
      print("Error signing in with google: ${mapFirebaseAuthExceptionCode(errorCode : error.code)}");
      throw Exception(mapFirebaseAuthExceptionCode(errorCode: error.code));
    }
    
    catch(error){
      print("Error signing in with Google: $error");
    }
  }
  
}


