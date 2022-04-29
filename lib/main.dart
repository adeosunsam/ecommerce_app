import 'package:ecommerce_store/components/route.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:ecommerce_store/screen/profile/components/edit_profile.dart';
import 'package:ecommerce_store/screen/splash/splash_screeen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Raleway',
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.grey),
      ),
      home: const WelcomeScreen(),
      routes: {
        editProfileRoute: (context) => const EditProfile(),
        shoppingRoute: (context) => const Shoppingaddress(),
        orderHistoryRoute: (context) => const Orderhistory(),
        notificationRoute: (context) => const Notifications(),
        cardRoute: (context) => const Cards(),
      },
    );
  }
}
