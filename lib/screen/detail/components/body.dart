import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/detail/components/product_detail_image.dart';
import 'package:ecommerce_store/screen/detail/components/product_detail_info.dart';

import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  final Product product;
  const Body({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          ProductDetailInfo(product: widget.product),
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: ProductImage(imageSet: widget.product.image),
          ),
        ],
      ),
    );
  }
}
