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
  List<Product> newList = [];
  callback(List<Product> getList) {
    setState(() {
      newList = getList;
    });
  }

  onLoadCartProducts() async {
    final cartList =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.cart);
    if (cartList != null) {
      final productList = productFromJson(cartList);
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
                    ? CartScreenBody(newList: newList)
                    : EmptyScreen(
                        errorImage: Image.asset('assets/images/cartempty.png'),
                        press: () {},
                        title: 'Your cart is empty!',
                      ),
              );

            default:
              return Container(
                color: kbackground,
                height: size.height,
                width: double.infinity,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
          }
        });
  }
}

class CartScreenBody extends StatefulWidget {
  final List<Product> newList;
  const CartScreenBody({
    Key? key,
    required this.newList,
  }) : super(key: key);

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
          child: SingleChildScrollView(
            child: Column(
              children: widget.newList.map((e) {
                return CartBody(
                  cartproduct: e,
                  onCallBack: callbackvoid,
                );
              }).toList(),
            ),
          ),
        ),
        CartTotalPrice(
          press: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckOutScreen(
                totalQuantity:
                    widget.newList.fold<int>(0, (a, b) => a + b.quantity),
              ),
            ),
          ),
          text: 'Checkout',
        ),
      ],
    );
  }
}
