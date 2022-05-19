import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/detail/product_detail.dart';
import 'package:flutter/material.dart';

class ItemBuider extends StatelessWidget {
  final Product product;
  const ItemBuider({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: size.height * 0.11),
            child: Container(
              margin: EdgeInsets.only(left: size.width * 0.1),
              height: size.height * 0.3,
              width: size.width * 0.47,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * 0.16),
                      child: Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Text(
                        'Series 6 Red',
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: kPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          Positioned(
            left: size.width * 0.16,
            child: Image.network(
              product.image,
              width: size.width * .35,
              height: size.height * .3,
            ),
            // child: Image(
            //   image: NetworkImage(product.image),
            //   width: size.width * .35,
            //   height: size.height * .3,
            // )
            // child: Image.asset(
            //   product.image,
            //   width: size.width * .35,
            //   height: size.height * .3,
            //   //scale: 2.3,
            // ),
          ),
        ],
      ),
    );
  }
}
