import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/fav_product.dart';
import 'package:ecommerce_store/screen/favorite/components/empty_wishlist.dart';
import 'package:ecommerce_store/screen/favorite/components/fav_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoriteScreen extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Function oncallbackFuntion;
  const FavoriteScreen({
    Key? key,
    required this.controller,
    required this.scaleAnimation,
    required this.oncallbackFuntion,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isCollapsed = true;
  final Duration duration = const Duration(milliseconds: 300);

  callback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.43 * size.width,
      right: isCollapsed ? 0 : -.4 * size.width,
      duration: duration,
      child: ScaleTransition(
        scale: widget.scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.circular(!isCollapsed ? 20 : 0),
          elevation: isCollapsed ? 0 : 5,
          color: kbackground,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (isCollapsed) {
                                widget.controller.forward();
                              } else {
                                widget.controller.reverse();
                              }
                              isCollapsed = !isCollapsed;
                            });
                            widget.oncallbackFuntion(isCollapsed);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              'assets/icons/menu.svg',
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: size.width * .2),
                          child: const Text(
                            'Favourites',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  favProducts.isNotEmpty
                      // ignore: prefer_const_constructors
                      ? FavProducts(oncallbackFunction: callback)
                      : EmptyScreen(
                          errorImage: Image.asset('assets/images/fav.png'),
                          press: () {},
                          title: 'No favourites yet',
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
