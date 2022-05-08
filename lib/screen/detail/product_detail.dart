import 'dart:convert';

import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/detail/components/body.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  onload() async {
    final prefs = await SharedPreferences.getInstance();
    final readOldList = prefs.getString(SharedConstants.fav);
    Iterable<Product>? fav;

    if (readOldList != null) {
      final productList = productFromJson(readOldList);
      fav = productList.where((element) => element.id == widget.product.id);
      if (fav.isNotEmpty) {
        onAdd = true;
      }
    }
  }

  checkpref() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove(SharedConstants.fav);
    final readOldList = prefs.getString(SharedConstants.fav);
    Iterable<Product>? fav;

    if (readOldList != null) {
      final productList = productFromJson(readOldList);
      fav = productList.where((element) => element.id == widget.product.id);
      if (fav.isNotEmpty) {
        onAdd = true;
      }

      productList.add(widget.product);
      final str = jsonEncode(productList);
      prefs.setString(SharedConstants.fav, str);
    } else {
      List<Product> newList = [];
      newList.add(widget.product);
      prefs.setString(SharedConstants.fav, jsonEncode(newList));
      onAdd = true;
    }

    //return fav != null ? true : false;
  }

  bool onAdd = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await onload();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackground,
      appBar: AppBar(
        backgroundColor: kbackground,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () async {
              await checkpref();
              // if (fav) {
              // } else {}
              setState(() {
                // if (fav.isEmpty) {
                //   favProducts.add(widget.product);
                // } else {
                //   favProducts.remove(widget.product);
                // }
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                onAdd ? 'assets/icons/heart1.svg' : 'assets/icons/heart.svg',
              ),
            ),
          )
        ],
      ),
      body: Body(product: widget.product),
    );
  }
}
