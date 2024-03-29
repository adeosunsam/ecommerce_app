import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/home/components/product_item_builder.dart';
import 'package:flutter/material.dart';

class Items extends StatefulWidget {
  final List<Product> listProduct;
  const Items({
    Key? key,
    required this.listProduct,
  }) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.43,
      child: ListView.builder(
          itemCount: widget.listProduct.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ItemBuider(
              product: widget.listProduct[index],
            );
          }),
    );
  }
}
