import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:ecommerce_store/screen/login/components/login_fields.dart';
import 'package:ecommerce_store/services/authservice/auth_service.dart';
import 'package:ecommerce_store/services/bloc/auth_bloc.dart';
import 'package:ecommerce_store/services/bloc/auth_event.dart';
import 'package:ecommerce_store/services/bloc/auth_state.dart';
import 'package:ecommerce_store/utility/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(AuthServices()),
      child: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventGetUser());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? 'Please wait a moment',
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedUser || state is AuthStateLoggedIn) {
          return const ProductPage();
        } else if (state is AuthStateLoggedOut) {
          return const LoginScaffold();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
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
              child: Stack(children: [
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
              ]),
            ),
            const LoginField(),
          ],
        ),
      ),
    );
  }
}
