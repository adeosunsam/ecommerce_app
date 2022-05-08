import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/cart/components/cart_total.dart';
import 'package:ecommerce_store/screen/checkout/components/payment_method.dart';
import 'package:ecommerce_store/screen/checkout/components/shipping_info.dart';
import 'package:ecommerce_store/screen/paynow/pay_now.dart';
import 'package:ecommerce_store/utility/pay_now_dialog.dart';
import 'package:flutter/material.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kbackground,
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: kbackground,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            height: size.height * .65,
            margin: EdgeInsets.symmetric(horizontal: size.width * .1),
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  ShippingInformation(),
                  PaymentMethod(),
                ],
              ),
            ),
          ),
          CartTotalPrice(
            press: () async {
              await showPayNowDialog(context);
              // Navigator.of(context).push(PageRouteBuilder(
              //     //barrierDismissible: true,
              //     opaque: false,
              //     //barrierColor: Colors.black54,
              //     pageBuilder: (context, _, __) {
              //       return showPayNowDialog(context);
              //     }));
            },
            text: 'Confirm and pay',
          ),
        ],
      ),
    );
  }
}
