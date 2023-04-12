// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_thing/screens/profile_page.dart';
import '../fire_auth.dart';
import '../validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        backgroundColor:
            const Color.fromRGBO(36, 34, 73, 120), // Set the background color
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Color.fromRGBO(99, 227, 227, 300),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 16.0),
                      TextFormField(
                          style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          controller: _emailTextController,
                          focusNode: _focusEmail,
                          validator: (value) => Validator.validateEmail(
                                email: value,
                              ),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: const TextStyle(color: Colors.white),
                            errorStyle: const TextStyle(color: Colors.red),
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const SizedBox(height: 16.0),
                      TextFormField(
                          style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          controller: _passwordTextController,
                          focusNode: _focusPassword,
                          obscureText: true,
                          validator: (value) => Validator.validatePassword(
                                password: value,
                              ),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: const TextStyle(color: Colors.white),
                            errorStyle: const TextStyle(color: Colors.red),
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          )),
                      const SizedBox(height: 32.0),
                      _isProcessing
                          ? const CircularProgressIndicator()
                          : Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _isProcessing = true;
                                      });

                                      print('Register button pressed');

                                      if (_registerFormKey.currentState!
                                          .validate()) {
                                        User? user = await FireAuth
                                            .registerUsingEmailPassword(
                                          email: _emailTextController.text,
                                          password:
                                              _passwordTextController.text,
                                          context: context,
                                        );

                                        setState(() {
                                          _isProcessing = false;
                                        });

                                        if (user != null) {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfilePage(user: user),
                                            ),
                                            ModalRoute.withName('/'),
                                          );
                                        }
                                      } else {
                                        setState(() {
                                          _isProcessing = false;
                                        });
                                      }
                                    },
                                    child: const Text(
                                      'Sign up',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
