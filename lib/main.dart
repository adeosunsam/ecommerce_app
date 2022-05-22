import 'dart:math';

import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:ecommerce_store/screen/splash/splash_screeen.dart';
import 'package:ecommerce_store/services/authservice/auth_service.dart';
import 'package:ecommerce_store/services/bloc/auth_bloc.dart';
import 'package:ecommerce_store/services/bloc/auth_event.dart';
import 'package:ecommerce_store/services/bloc/auth_state.dart';
import 'package:ecommerce_store/services/gadget/get_gadget.dart';
// import 'package:ecommerce_store/utility/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.grey),
      ),
      //home: const WelcomeScreen(),
      home: BlocProvider(
        create: (context) => AuthBloc(AuthServices(), GadgetService()),
        child: const Onboard(),
      ),
    );
  }
}

class Onboard extends StatelessWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const GetDataEvent());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state.isLoading) {
          const LoadingWidgetPage();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedUser || state is AuthStateLoggedIn) {
          return const ProductPage();
        } else if (state.isLoading && state is AuthStateLoggedOut) {
          return const LoadingWidgetPage();
        } else if (state is AuthStateLoggedOut) {
          return const WelcomeScreen();
        } else if (state is GetDataStateFailed) {
          return const DataLoadErrorPage();
        } else {
          return const LoadingWidgetPage();
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
              'Your internet connection is currently not available please check or try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingWidgetPage extends StatefulWidget {
  const LoadingWidgetPage({Key? key}) : super(key: key);

  @override
  State<LoadingWidgetPage> createState() => _LoadingWidgetPageState();
}

class _LoadingWidgetPageState extends State<LoadingWidgetPage>
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
