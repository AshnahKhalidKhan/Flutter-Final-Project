/*
  NOTE-TO-SELF:
  - Sign up email
  - Sign up google (??)
  - Sign in email
  - Sign in google
  - Ask Sir: phone number authentication for Whatsapp??
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_final_project/Models/UserModel.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository 
{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  AuthenticationRepository
  (
    {
      required this.firebaseFirestore,
      required this.firebaseAuth,
    }
  );

  Stream<User?> get user => firebaseAuth.userChanges();
  
  Future<void> signOut() async 
  {
    await firebaseAuth.signOut();
  }

  Future<AppUser?> signUpWithEmail
  ( 
    {
      required String name,
      required String email,
      required String password,
      required String role,
      String? campus
    }
  )
  async
  {
    try 
    {
      final UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword
      (
        email: email,
        password: password
      );
      final User signedInUser = userCredential.user!;
      AppUser user = AppUser
      (
        id: signedInUser.uid,
        name: name,
        email: email,
        role: role,
        campus: campus,
        approved: false
      );
      await FirebaseFirestore.instance.collection('Users').doc(signedInUser.uid).set(user.toJson());
    }
    catch (e) 
    {
      print('Error in AuthenticationRepository, signUpWithEmail: $e');
    }
  }

  Future<void> signInWithEmail
  (
    {
      required String email,
      required String password,
    }
  )
  async
  {
    try 
    {
      await firebaseAuth.signInWithEmailAndPassword
      (
        email: email, 
        password: password
      );
    }
    catch (e) 
    {
      print('Error in AuthenticationRepository, signInWithEmail: $e');
    }
  }

  Future<void> signInWithGoogle
  (
    {
      // required String name,
      // required String email,
      // required String password,
      required String role,
      String? campus
    }
  )
  async
  {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount == null) 
    {
      print('Error in AuthenticationRepository, signInWithGoogle.... googleSignInAccount == nulll');
    }
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential
    (
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken
    );
    
    try 
    {
      final UserCredential userCredential = await firebaseAuth.signInWithCredential(authCredential);
      final User? signedInUser = userCredential.user;
      final appUserFromFirebase = await FirebaseFirestore.instance.collection('Users').doc(signedInUser!.uid).get();
      if (appUserFromFirebase.exists == false)
      {
        AppUser user = AppUser
        (
          id: signedInUser.uid,
          name: signedInUser.displayName ?? '',
          email: signedInUser.email ?? '',
          role: role,
          campus: campus,
          approved: false
        );
        await FirebaseFirestore.instance.collection('Users').doc(signedInUser!.uid).set(user.toJson());
      }
    }
    catch (e) 
    {
      print('Error in AuthenticationRepository, signInWithGoogle: $e');
    }

  }
}