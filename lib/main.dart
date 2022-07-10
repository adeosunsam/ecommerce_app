import 'dart:convert';
import 'dart:math';

import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:ecommerce_store/screen/login/login_screen.dart';
import 'package:ecommerce_store/services/authservice/auth_service.dart';
import 'package:ecommerce_store/services/bloc/auth_bloc.dart';
import 'package:ecommerce_store/services/bloc/auth_event.dart';
import 'package:ecommerce_store/services/bloc/auth_state.dart';
import 'package:ecommerce_store/utility/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Just Gadget',
        theme: ThemeData(
          fontFamily: 'Raleway',
          primaryColor: kPrimary,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.grey),
        ),
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 2).animate(_controller);
    _controller.repeat();
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => AuthBloc(
              AuthServices(),
            ),
            child: const HomePageCheck(),
          );
        }));
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controller.value * 3 * pi,
              child: child,
            );
          },
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _controller.value * .2 * pi,
                child: child,
              );
            },
            child: Container(
              width: 100,
              height: 100,
              color: kbackground,
            ),
          ),
        ),
      ),
    );
  }
}

// class Onboarding extends StatelessWidget {
//   const Onboarding({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       builder: (context, child) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Just Gadget',
//         theme: ThemeData(
//           fontFamily: 'Raleway',
//           primaryColor: kPrimary,
//           textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.grey),
//         ),
//         themeMode: ThemeMode.system,
//         home: BlocProvider(
//           create: (context) => AuthBloc(
//             AuthServices(),
//           ),
//           child: const HomePageCheck(),
//         ),
//       ),
//     );
//   }
// }

class HomePageCheck extends StatelessWidget {
  const HomePageCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventGetUser());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
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
          return const LoginScreen();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class DataLoadErrorPage extends StatelessWidget {
  const DataLoadErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kbackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/internet.png"),
          const Text(
            "No Internet Connection",
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              fontSize: 21,
              color: Colors.black,
            ),
          ),
          SizedBox(height: size.height * .03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .18),
            child: const Text(
              'Your internet connection is currently not available please check and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(height: size.height * .03),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ),
              );
            },
            child: const Text(
              'Try Again',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              elevation: 5,
              primary: const Color(0xFF58C0EA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
