import 'package:ecommerce_store/components/rounded_button.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartTotalPrice extends StatefulWidget {
  final String text;
  final VoidCallback press;
  const CartTotalPrice({
    Key? key,
    required this.text,
    required this.press,
  }) : super(key: key);

  @override
  State<CartTotalPrice> createState() => _CartTotalPriceState();
}

class _CartTotalPriceState extends State<CartTotalPrice> {
  List<CartProduct> getCartProducts = [];
  onload() async {
    final cartList =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.cart);
    if (cartList != null) {
      final productList = gadgetFromJson(cartList);
      getCartProducts = productList;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final formatCurrency = NumberFormat.currency(locale: "en_US");
    return FutureBuilder(
        future: onload(),
        builder: (context, snapshot) {
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
                        formatCurrency.format(getCartProducts.fold<double>(
                            0, (a, b) => a + (b.quantity * b.price))),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // fontFamily: 'Raleway',
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
                    text: widget.text,
                    press: widget.press,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
