
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository 
{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  AuthRepository
  (
    {
      required this.firebaseFirestore,
      required this.firebaseAuth,
    }
  );

  //CREATE, READ, UPDATE, DELETE

  Future<void> signOut() async 
  {
    await firebaseAuth.signOut();
  }

  Future<void> signUpWithEmail
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
      User user;
      switch (role)
      {
        case 'member':
        {
          user = User
          (

          );
          break;
        }
      }
      User user = User
      (
        id: signedInUser.uid,
        name: name,
        email: email,
        role: 'member',
        campus: campus,
        approved: false
      );
      await usersRef.doc(signedInUser.uid).set(user.toJson());
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}