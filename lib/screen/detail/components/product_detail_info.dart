import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/detail/components/single_product_desc.dart';
import 'package:flutter/material.dart';

class ProductDetailInfo extends StatefulWidget {
  final Product product;
  const ProductDetailInfo({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailInfo> createState() => _ProductDetailInfoState();
}

class _ProductDetailInfoState extends State<ProductDetailInfo> {
  bool descClicked = false;
  callback() {
    setState(() {
      descClicked = !descClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: descClicked ? size.height * .62 : size.height * .56,
      width: double.infinity,
      margin: EdgeInsets.only(top: size.height * 0.33),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleProductDescription(
          oncallbackFunction: callback, product: widget.product),
    );
  }
}
