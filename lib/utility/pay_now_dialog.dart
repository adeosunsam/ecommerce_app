import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/cart/components/cart_total.dart';
import 'package:flutter/material.dart';

Future showPayNowDialog(BuildContext context, int totalQuantity) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (_) => Material(
            type: MaterialType.transparency,
            child: Container(
              margin: EdgeInsets.only(top: size.height * .4),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .35,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * .1,
                            vertical: size.height * .05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Confirm and pay',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'products: ',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '$totalQuantity',
                                    style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CartTotalPrice(
                    text: 'Pay now',
                    press: () {},
                  ),
                ],
              ),
            ),
          ));
}
