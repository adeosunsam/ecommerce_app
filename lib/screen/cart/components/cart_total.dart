import 'package:ecommerce_store/components/rounded_button.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/cart_product.dart';
import 'package:flutter/material.dart';

class CartTotalPrice extends StatelessWidget {
  final String text;
  final VoidCallback press;
  const CartTotalPrice({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '\$${cartProducts.fold<double>(0, (a, b) => a + (b.quantity * b.price))}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway',
                    color: kPrimary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * .03,
          ),
          SizedBox(
            child: RoundedButton(
              buttonColor: kPrimary,
              textColor: Colors.white,
              text: text,
              press: press,
            ),
          ),
        ],
      ),
    );
  }
}
