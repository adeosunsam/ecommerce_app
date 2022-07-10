import 'dart:convert';

import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/cart/components/cart_body.dart';
import 'package:ecommerce_store/screen/cart/components/cart_total.dart';
import 'package:ecommerce_store/screen/checkout/checkout_page.dart';
import 'package:ecommerce_store/screen/favorite/components/empty_wishlist.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final Function callbackFunction;
  const CartScreen({
    Key? key,
    required this.callbackFunction,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartProduct> newList = [];
  callback(List<CartProduct> getList) {
    setState(() {
      newList = getList;
    });
  }

  callbackDeleteOne() {
    setState(() {});
  }

  onLoadCartProducts() async {
    final cartList =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.cart);
    if (cartList != null) {
      final productList = gadgetFromJson(cartList);
      newList = productList;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: onLoadCartProducts(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
            case ConnectionState.waiting:
              return Scaffold(
                backgroundColor: kbackground,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: kbackground,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: const Text(
                    'Basket',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Raleway',
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        if (newList.isEmpty) {
                          return;
                        }
                        AuthProvider.fromapi()
                            .removePref(key: SharedConstants.cart);
                        newList = [];
                        widget.callbackFunction();
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: size.width * .1),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
                body: newList.isNotEmpty
                    ? CartScreenBody(
                        newList: newList,
                        onCallBackFunction: callbackDeleteOne,
                        callCountFunction: widget.callbackFunction,
                      )
                    : snapshot.connectionState == ConnectionState.done
                        ? EmptyScreen(
                            errorImage:
                                Image.asset('assets/images/cartempty.png'),
                            press: () {},
                            title: 'Your cart is empty!',
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: kPrimary,
                            ),
                          ),
              );

            default:
              return Container(
                color: kbackground,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: kPrimary,
                  ),
                ),
              );
          }
        });
  }
}

class CartScreenBody extends StatefulWidget {
  final List<CartProduct> newList;
  final Function onCallBackFunction;
  final Function callCountFunction;
  const CartScreenBody({
    Key? key,
    required this.newList,
    required this.onCallBackFunction,
    required this.callCountFunction,
  }) : super(key: key);

  @override
  State<CartScreenBody> createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  callbackvoid() {
    setState(() {});
  }

  deleteOneItem(String id) {
    widget.newList.removeWhere((element) => element.id == id);
    AuthProvider.fromapi().setSharedPref(
        key: SharedConstants.cart, value: jsonEncode(widget.newList));
    if (widget.newList.isEmpty) {
      widget.onCallBackFunction();
    } else {
      setState(() {});
    }
    widget.callCountFunction();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .63,
          child: SingleChildScrollView(
            child: Column(
              children: widget.newList.map((e) {
                return CartBody(
                  cartproduct: e,
                  onCallBack: callbackvoid,
                  onCallBackFunction: deleteOneItem,
                );
              }).toList(),
            ),
          ),
        ),
        CartTotalPrice(
          press: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckOutScreen(
                  totalQuantity:
                      widget.newList.fold<int>(0, (a, b) => a + b.quantity),
                ),
              ),
            );
          },
          text: 'Checkout',
        ),
      ],
    );
  }
}
