import 'dart:convert';

import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/cart/components/set_quantity.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartBody extends StatefulWidget {
  final CartProduct cartproduct;
  final Function onCallBack;
  final Function onCallBackFunction;
  const CartBody({
    Key? key,
    required this.cartproduct,
    required this.onCallBack,
    required this.onCallBackFunction,
  }) : super(key: key);

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  callback(int value) async {
    final cartList =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.cart);
    if (cartList != null) {
      final productList = gadgetFromJson(cartList);
      CartProduct product = productList
          .firstWhere((element) => element.id == widget.cartproduct.id);
      productList.removeWhere((element) => element.id == product.id);

      setState(() {
        if (value == -1 && widget.cartproduct.quantity == 1) {
          widget.cartproduct.quantity = widget.cartproduct.quantity;
        } else if (value == -1) {
          widget.cartproduct.quantity += value;
          product.quantity += value;
        } else if (value == 1) {
          widget.cartproduct.quantity += value;
          product.quantity += value;
        }
        productList.add(product);
        AuthProvider.fromapi().setSharedPref(
            key: SharedConstants.cart, value: jsonEncode(productList));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final formatCurrency = NumberFormat.currency(locale: "en_US");
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * .1,
        vertical: size.height * .01,
      ),
      height: size.height * .18,
      width: size.width * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    widget.cartproduct.image,
                    height: size.height * .23,
                    width: size.width * .23,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: size.height * .02),
                          Text(
                            widget.cartproduct.title,
                            style: const TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: size.height * .018),
                          Text(
                            formatCurrency.format((widget.cartproduct.quantity *
                                widget.cartproduct.price)),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              //fontFamily: 'Raleway',
                              color: kPrimary,
                            ),
                          ),
                          SizedBox(height: size.height * .016),
                          Row(
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Raleway',
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: size.width * .02),
                              Quantity(
                                oncallTotalPrice: widget.onCallBack,
                                oncallBackFunction: callback,
                                icon: Icons.remove,
                              ),
                              SizedBox(width: size.width * .02),
                              Text(
                                '${widget.cartproduct.quantity}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Raleway',
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: size.width * .02),
                              Quantity(
                                oncallTotalPrice: widget.onCallBack,
                                oncallBackFunction: callback,
                                icon: Icons.add,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  //newList.removeWhere((element) => element.id == favproduct.id);

                  // AuthProvider.fromapi().setSharedPref(
                  //     key: SharedConstants.fav, value: jsonEncode(newList));
                  // if (newList.isEmpty) {
                  //   //widget.onCallBackFunction();
                  // } else {
                  //   setState(() {});
                  // }
                  widget.onCallBackFunction(widget.cartproduct.id);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: kPrimary,
                  ),
                  child: const Icon(
                    Icons.clear_rounded,
                    color: Colors.white,
                    size: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
