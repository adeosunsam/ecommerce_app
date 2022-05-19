import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:ecommerce_store/screen/splash/splash_screeen.dart';
import 'package:ecommerce_store/services/authservice/auth_service.dart';
import 'package:ecommerce_store/services/bloc/auth_bloc.dart';
import 'package:ecommerce_store/services/bloc/auth_event.dart';
import 'package:ecommerce_store/services/bloc/auth_state.dart';
import 'package:ecommerce_store/services/gadget/get_gadget.dart';
import 'package:ecommerce_store/utility/loading_screen.dart';
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
          return const WelcomeScreen();
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
