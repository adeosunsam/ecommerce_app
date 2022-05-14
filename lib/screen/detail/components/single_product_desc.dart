import 'dart:convert' show jsonEncode;

import 'package:ecommerce_store/components/rounded_button.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/detail/components/description_collapse.dart';
import 'package:ecommerce_store/screen/detail/components/product_color.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';

import 'package:ecommerce_store/utility/add_to_cart.dart';
import 'package:ecommerce_store/utility/item_already_present.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';

class SingleProductDescription extends StatefulWidget {
  final Function oncallbackFunction;
  final Product product;
  const SingleProductDescription({
    Key? key,
    required this.product,
    required this.oncallbackFunction,
  }) : super(key: key);

  @override
  State<SingleProductDescription> createState() =>
      _SingleProductDescriptionState();
}

class _SingleProductDescriptionState extends State<SingleProductDescription> {
  onAddToCart() async {
    final readOldList =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.cart);
    Iterable<Product>? productPresent;

    if (readOldList != null) {
      final productList = productFromJson(readOldList);
      productPresent =
          productList.where((element) => element.id == widget.product.id);
      if (productPresent.isNotEmpty) {
        await showPresentInCartDialog(context);
      } else if (productPresent.isEmpty) {
        productList.add(widget.product);
        final str = jsonEncode(productList);
        await AuthProvider.fromapi()
            .setSharedPref(key: SharedConstants.cart, value: str);
        await showAddedToCartDialog(context);
      }
    } else {
      List<Product> newList = [];
      newList.add(widget.product);
      AuthProvider.fromapi()
          .setSharedPref(key: SharedConstants.cart, value: jsonEncode(newList));
      await showAddedToCartDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.03),
          Text(
            widget.product.title,
            style: const TextStyle(
              fontFamily: 'Raleway',
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: size.height * 0.025),
          const Text(
            'Colors',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Raleway',
              color: Colors.black,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          const ProductColor(),
          SizedBox(height: size.height * 0.03),
          CollapseDescription(
              callbackFunction: widget.oncallbackFunction,
              text: widget.product.description),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Text(
                '\$${widget.product.price}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Raleway',
                  color: kPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.035),
          RoundedButton(
              press: () {
                onAddToCart();
                //Navigator.of(context).pop();
              },
              buttonColor: kPrimary,
              textColor: Colors.white,
              text: 'Add to basket')
        ],
      ),
    );
  }
}
