import 'package:ecommerce_store/components/rounded_button.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: size.width * 0.14,
              top: size.height * 0.05,
            ),
            child: Text(
              'Find your Gadget',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: size.width * 0.17,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: size.height * 0.17),
                child: Image.asset(
                  'assets/images/start.png',
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: size.height * 0.48),
                child: Image.asset(
                  'assets/images/blur.png',
                  scale: .1,
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: size.height * 0.13),
            child: RoundedButton(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductPage(),
                  ),
                );
              },
              text: 'Get Started',
              textColor: kPrimary,
              buttonColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
