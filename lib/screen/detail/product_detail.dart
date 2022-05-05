import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/fav_product.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/detail/components/body.dart';
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
  @override
  Widget build(BuildContext context) {
    var fav = favProducts.where((element) => element.id == widget.product.id);
    return Scaffold(
      backgroundColor: kbackground,
      appBar: AppBar(
        backgroundColor: kbackground,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          GestureDetector(
            onTap: () async {
              setState(() {
                if (fav.isEmpty) {
                  favProducts.add(widget.product);
                } else {
                  favProducts.remove(widget.product);
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: SvgPicture.asset(
                fav.isNotEmpty
                    ? 'assets/icons/heart1.svg'
                    : 'assets/icons/heart.svg',
              ),
            ),
          )
        ],
      ),
      body: Body(product: widget.product),
    );
  }
}
