// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_thing/screens/signup.dart';
import '../login_components.dart/my_button.dart';
import '../login_components.dart/my_textfield.dart';
import 'package:movie_thing/screens/forgotPassword.dart';
import 'package:movie_thing/screens/facebook.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final double _sigmaX = 1; // from 0-10
  final double _sigmaY = 1; // from 0-10
  final double _opacity = 0.2;
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height, //muokkaa kuvan kokoa
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  //muuttaa welcome sivun taustakuvan
                  'https://images.unsplash.com/photo-1629197521865-4946b4acd2b0?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bmF2eSUyMGJsdWV8ZW58MHx8MHx8&w=1000&q=80',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                    SizedBox(
                        height: (1.0)), // muokkaa myös welcome paikkaa sivulla
                    const Text("Welcome!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                        height:
                            30.0), // muokkaa textbox kohtaa welcome verattuna
                    ClipRect(
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(0, 0, 0, 1)
                                  .withOpacity(_opacity),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height *
                              0.63, // ei kannata koskea
                          child: Form(
                            key: _formKey,
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // username textfield
                                  MyTextField(
                                    controller: usernameController,
                                    hintText: 'Email',
                                    obscureText: false,
                                  ),

                                  const SizedBox(
                                      height:
                                          30), //muokkaa continue korkeutta welcomeen verrattuna

                                  // sign in button
                                  MyButton(
                                    onTap: (() {
                                      if (_formKey.currentState!.validate()) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Signup()),
                                        );
                                      } else {
                                        print('not valid');
                                      }
                                    }),
                                  ),

                                  const SizedBox(height: 10),

                                  // or continue with
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(
                                          'Or',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          thickness: 0.5,
                                          color: Colors.grey[400],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 2),

                                  // google + apple sign in buttons?
                                  Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // facebook button
                                        TextButton(
                                          child: Text('Log in with Facebook',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 71, 233, 133),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              textAlign: TextAlign.start),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Facebook()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),

                                  // not a member? register now
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(
                                              'Don\'t have an account?',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 71, 233, 133),
                                                  fontSize: 18),
                                              textAlign: TextAlign.start,
                                            ),
                                            const SizedBox(width: 4),
                                            TextButton(
                                              child: const Text(
                                                'Sign Up',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 71, 233, 133),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Signup()),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        TextButton(
                                          child: const Text('Forgot Password?',
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 71, 233, 133),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              textAlign: TextAlign.start),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPassword()),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
