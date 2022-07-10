import 'dart:io';

import 'package:ecommerce_store/components/password_input_field.dart';
import 'package:ecommerce_store/components/rounded_button.dart';
import 'package:ecommerce_store/components/text_input_field.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/services/bloc/auth_bloc.dart';
import 'package:ecommerce_store/services/bloc/auth_event.dart';
import 'package:ecommerce_store/services/bloc/auth_state.dart';
import 'package:ecommerce_store/utility/exception.dart';
import 'package:ecommerce_store/utility/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is BadOrNoNetworkException) {
            await showErrorDialog(context, 'Network Failure');
          } else if (state.exception is InvalidLoginCredential) {
            await showErrorDialog(context, 'Invalid login credential');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
        backgroundColor: kPrimary,
        body: WillPopScope(
          onWillPop: () => onbackPress(context),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: size.height * .62,
                  width: double.infinity,
                  margin: EdgeInsets.only(top: size.height * 0.38),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                ),
                SafeArea(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        right: size.width * 0.1,
                        child: Image.asset(
                          'assets/images/ellipse.png',
                          scale: .8,
                        ),
                      ),
                      Positioned(
                        top: size.height * .005,
                        right: 0,
                        child: Image.asset(
                          'assets/images/blur.png',
                          scale: .8,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.15,
                          vertical: size.height * 0.09,
                        ),
                        child: const Text(
                          'Welcome back',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.24,
                        right: size.width * 0.15,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 126, 124, 242),
                              width: 6.3,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.03,
                        left: size.width * 0.18,
                        child: Container(
                          width: 27,
                          height: 27,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 126, 124, 242),
                              width: 6,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.42),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/email.svg',
                              width: 22,
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        InputTextField(
                          text: _email,
                          hintText: 'example@gmail.com',
                        ),
                        SizedBox(height: size.height * 0.04),
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/lock.svg',
                              width: 22,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                        PasswordInputField(
                          text: _password,
                          hintText: 'password',
                        ),
                        SizedBox(height: size.height * 0.03),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Forget Passcode?',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 18,
                              color: kPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        RoundedButton(
                          press: () async {
                            final email = _email.text;
                            final password = _password.text;
                            if (email.isEmpty || password.isEmpty) {
                              await showErrorDialog(
                                  context, 'email and password required');
                            } else {
                              context.read<AuthBloc>().add(
                                    AuthEventLogin(
                                      email,
                                      password,
                                    ),
                                  );
                            }
                          },
                          buttonColor: kPrimary,
                          textColor: Colors.white,
                          text: 'Login',
                        ),
                        SizedBox(height: size.height * 0.02),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Create account',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 20,
                                color: kPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<bool> onbackPress(BuildContext context) {
  openDialog(context);
  return Future.value(false);
}

Future<void> openDialog(BuildContext context) async {
  switch (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          contentPadding: EdgeInsets.zero,
          children: [
            Container(
              color: kPrimary,
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: const Icon(
                      Icons.exit_to_app,
                      size: 30,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                  ),
                  const Text(
                    'Exit app',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Are you sure to exit app?',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 0);
              },
              child: Row(
                children: [
                  Container(
                    child: const Icon(
                      Icons.cancel,
                      color: kPrimary,
                    ),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  const Text(
                    'Cancel',
                    style: TextStyle(
                      color: kPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, 1);
              },
              child: Row(
                children: [
                  Container(
                    child: const Icon(
                      Icons.check_circle,
                      color: kPrimary,
                    ),
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  const Text(
                    'Yes',
                    style: TextStyle(
                      color: kPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      })) {
    case 0:
      break;
    case 1:
      exit(0);
  }
}
