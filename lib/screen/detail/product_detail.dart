import 'dart:convert';

import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/detail/components/body.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    final readOldList =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.fav);
    Iterable<Product>? fav;

    if (readOldList != null) {
      final productList = productFromJson(readOldList);
      fav = productList.where((element) => element.id == widget.product.id);
      if (fav.isNotEmpty) {
        onAdd = true;
      }
    }
  }

  onClickFav() async {
    final readOldList =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.fav);
    Iterable<Product>? fav;

    if (readOldList != null) {
      final productList = productFromJson(readOldList);
      fav = productList.where((element) => element.id == widget.product.id);
      if (fav.isNotEmpty) {
        productList.removeWhere((element) => element.id == widget.product.id);
        await AuthProvider.fromapi().setSharedPref(
            key: SharedConstants.fav, value: jsonEncode(productList));
      } else if (fav.isEmpty) {
        productList.add(widget.product);
        final str = jsonEncode(productList);
        await AuthProvider.fromapi()
            .setSharedPref(key: SharedConstants.fav, value: str);
      }
    } else {
      List<Product> newList = [];
      newList.add(widget.product);
      AuthProvider.fromapi()
          .setSharedPref(key: SharedConstants.fav, value: jsonEncode(newList));
    }
    onAdd = !onAdd;
  }

  bool onAdd = false;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance?.addPostFrameCallback((_) async {
  //     await onload();
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: onload(),
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: kbackground,
            appBar: AppBar(
              backgroundColor: kbackground,
              foregroundColor: Colors.black,
              elevation: 0,
              actions: [
                GestureDetector(
                  onTap: () async {
                    await onClickFav();
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      onAdd
                          ? 'assets/icons/heart1.svg'
                          : 'assets/icons/heart.svg',
                    ),
                  ),
                )
              ],
            ),
            body: Body(product: widget.product),
          );
        });
  }
}
