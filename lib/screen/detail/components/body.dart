import 'package:ecommerce_store/entity/fav_product.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/detail/components/product_detail_image.dart';
import 'package:ecommerce_store/screen/detail/components/product_detail_info.dart';
import 'package:ecommerce_store/screen/detail/components/single_product_desc.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    var fav = favProducts.where((element) => element.id == widget.product.id);
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          const ProductDetailInfo(),
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductPage(),
                                ));
                          },
                          child: const Icon(Icons.arrow_back),
                        ),
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
                          child: SvgPicture.asset(
                            fav.isNotEmpty
                                ? 'assets/icons/heart1.svg'
                                : 'assets/icons/heart.svg',
                          ),
                        )
                      ],
                    ),
                  ),
                  ProductImage(imageSet: widget.product.image)
                ],
              ),
            ),
          ),
          SingleProductDescription(product: widget.product),
        ],
      ),
    );
  }
}
