import 'package:ecommerce_store/components/password_input_field.dart';
import 'package:ecommerce_store/components/rounded_button.dart';
import 'package:ecommerce_store/components/text_input_field.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/services/bloc/auth_bloc.dart';
import 'package:ecommerce_store/services/bloc/auth_event.dart';
import 'package:ecommerce_store/services/bloc/auth_state.dart';
import 'package:ecommerce_store/utility/exception.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:ecommerce_store/utility/show_error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginField extends StatefulWidget {
  const LoginField({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
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
      child: Container(
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
                      context.read<AuthBloc>().add(AuthEventLogin(
                            email,
                            password,
                          ));
                    }
                  },
                  buttonColor: kPrimary,
                  textColor: Colors.white,
                  text: 'Login'),
              SizedBox(height: size.height * 0.02),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.2),
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
    );
  }
}
