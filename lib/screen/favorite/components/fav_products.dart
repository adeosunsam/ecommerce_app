import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/fav_product.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:flutter/material.dart';

class FavProducts extends StatefulWidget {
  final Function oncallbackFunction;
  const FavProducts({
    Key? key,
    required this.oncallbackFunction,
  }) : super(key: key);

  @override
  State<FavProducts> createState() => _FavProductsState();
}

class _FavProductsState extends State<FavProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: favProducts.map((e) {
        return favproductbuider(context, e);
      }).toList(),
    );
  }

  Widget favproductbuider(BuildContext context, Product favproduct) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * .1,
        vertical: size.height * .01,
      ),
      height: size.height * .15,
      width: size.width * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  favproduct.image,
                  height: size.height * .23,
                  width: size.width * .23,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          favproduct.name,
                          style: const TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: size.height * .018),
                        Row(
                          children: [
                            const Text(
                              'Starting from',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '\$${favproduct.price}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway',
                                color: kPrimary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    favProducts.remove(favproduct);
                  });
                  widget.oncallbackFunction();
                },
                child: const Icon(
                  Icons.clear,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
