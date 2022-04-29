import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/splash/components/body.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimary,
      body: Body(),
    );
  }
}
