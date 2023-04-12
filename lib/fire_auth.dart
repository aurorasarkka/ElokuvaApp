// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateProfile(displayName: email);
      await user.reload();
      user = auth.currentUser;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful'),
          duration: Duration(seconds: 3),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak password') {
        print('The password provided is too weak.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The password provided is too weak.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The account already exists for that email.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print('An error occurred');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign-in successful'),
          duration: Duration(seconds: 3),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print('No user found for that email.');
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No user found for that email.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Wrong password provided.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else if (e.code == 'invalid-email') {
        print('Invalid email provided.');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid email provided.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print('An error occurred');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await user.reload();
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  isLoggedIn() {}
}
