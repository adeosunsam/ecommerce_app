import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/favorite/components/empty_wishlist.dart';
import 'package:ecommerce_store/screen/favorite/components/fav_products.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
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

  bool hasData = false;
  ongetFav() async {
    final favouriteList =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.fav);
    if (favouriteList != null) {
      final productList = productFromJson(favouriteList);
      hasData = productList.isNotEmpty ? true : false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: ongetFav(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.done:
            case ConnectionState.waiting:
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
                    child: SafeArea(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * .03),
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: size.width * .2),
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
                          SizedBox(
                            height: size.height * .78,
                            child: hasData
                                ? FavProducts(onCallBackFunction: callback)
                                : snapshot.connectionState ==
                                        ConnectionState.done
                                    ? EmptyScreen(
                                        errorImage: Image.asset(
                                            'assets/images/fav.png'),
                                        press: () {},
                                        title: 'No favourites yet',
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator(
                                          color: kPrimary,
                                        ),
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            default:
              return Container(
                color: kbackground, //i need to set the back color to kprimary
                height: size.height,
                width: double.infinity,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
          }
        });
  }
}
