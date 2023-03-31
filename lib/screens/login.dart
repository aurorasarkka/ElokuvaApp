// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, must_be_immutable, library_private_types_in_public_api, unused_local_variable, depend_on_referenced_packages

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_thing/main.dart';
import 'package:movie_thing/screens/forgotPassword.dart';
import '../login_components.dart/my_button.dart';
import '../login_components.dart/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Declare the text editing controllers for the email and password fields.
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // Declare variables for the blur effect.
  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;
  // Create a form key for the login form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function to handle signing in the user.
  void signUserIn() async {
    // Validate the form.
    if (_formKey.currentState!.validate()) {
      try {
        final password = passwordController.text.trim();
        final email = emailController.text.trim();

        // Check if the email already exists in Firebase.
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // If the account exists, sign in with email and password.
          final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          // If the sign in is successful, navigate to the main app screen.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        } else {
          // If the account does not exist, show an error message asking the user to sign up.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('This email is not registered. Please sign up.'),
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        // If there is an error with the sign in, print the error message.
        print('Error: ${e.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Set the background image.
              Image.network(
                'https://images.unsplash.com/photo-1629197521865-4946b4acd2b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF2eSUyMGJsdWV8ZW58MHx8MHx8&w=1000&q=80',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.26),
                  const Text("Log in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(0, 0, 0, 1)
                                .withOpacity(_opacity),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(30))),
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [], //TÄHÄN KÄYTTÄJÄN SPOSTI
                                    )
                                  ]),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                MyTextField(
                                  controller: passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                MyButtonAgree(
                                  text: "Continue",
                                  onTap: () async {
                                    try {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()),
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      print('Error: ${e.message}');
                                    }
                                  },
                                ),
                                TextButton(
                                    child: const Text('Forgot Password?',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 71, 233, 133),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                        textAlign: TextAlign.start),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()),
                                      );
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
