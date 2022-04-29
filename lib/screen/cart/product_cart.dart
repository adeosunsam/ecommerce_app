import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/cart_product.dart';
import 'package:ecommerce_store/screen/cart/components/cart_body.dart';
import 'package:ecommerce_store/screen/cart/components/cart_total.dart';
import 'package:ecommerce_store/screen/favorite/components/empty_wishlist.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              setState(() {
                if (cartProducts.isNotEmpty) {
                  cartProducts.removeRange(0, cartProducts.length);
                }
              });
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
      body: cartProducts.isNotEmpty
          ? const CartScreenBody()
          : EmptyScreen(
              errorImage: Image.asset('assets/images/cartempty.png'),
              press: () {},
              title: 'Your cart is empty!',
            ),
    );
  }
}

class CartScreenBody extends StatefulWidget {
  const CartScreenBody({Key? key}) : super(key: key);

  @override
  State<CartScreenBody> createState() => _CartScreenBodyState();
}

class _CartScreenBodyState extends State<CartScreenBody> {
  callbackvoid() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * .63,
          //color: Colors.red,
          child: SingleChildScrollView(
            child: Column(
              children: cartProducts.map((e) {
                return CartBody(
                  cartproduct: e,
                  onCallBack: callbackvoid,
                );
              }).toList(),
            ),
          ),
        ),
        // ignore: prefer_const_constructors
        CartTotalPrice(),
      ],
    );
  }
}
