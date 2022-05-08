import 'package:flutter/material.dart';

class PayNowScreen extends StatefulWidget {
  const PayNowScreen({Key? key}) : super(key: key);

  @override
  State<PayNowScreen> createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .6,
      //decoration: BoxDecoration(color: Colors.white),
    );
  }
}
