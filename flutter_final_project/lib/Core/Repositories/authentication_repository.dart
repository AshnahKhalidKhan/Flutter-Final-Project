import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_final_project/models/user_model.dart';

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
    try 
    {
      await firebaseAuth.signOut();
    }
    catch (e) 
    {
      throw Exception('Unable to signout. Please try again.\n $e');
    }
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
      return user;
    }
    catch (e) 
    {
      throw Exception('Sign up failed. Please fill all fields accurately and try again.\n $e');
    }
  }

  Future<AppUser?> signInWithEmail
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
      final UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword
      (
        email: email, 
        password: password
      );
      if (userCredential != null)
      {
        final User? signedInUser = userCredential.user;
        if (signedInUser != null) 
        {
          final userFromFirebase = await FirebaseFirestore.instance.collection('Users').doc(signedInUser.uid).get();
          if (userFromFirebase.exists) 
          {
            final Map<String, dynamic>? userData = userFromFirebase.data();
            if (userData != null) 
            {
              AppUser user = AppUser.fromJson(userData);
              return user;
            }
          }
        }
      }
    }
    catch (e) 
    {
      throw Exception('Login failed. Please enter valid credentials and try again.\n $e');
    }
  }

  Future<String> forgotPassword
  (
    {
      required String email
    }
  )
  async
  {
    try 
    {
      await firebaseAuth.sendPasswordResetEmail
      (
        email: email
      );
      return 'A password reset link has been sent to your email address. Please follow the instructions in the email to reset your password.';
    }
    catch (e) 
    {
      throw Exception('Reset password failed. Please enter valid email and try again.\n $e');
    }
  }
}