import 'package:ecommerce_store/components/search_bar.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/home/components/category_builder.dart';
import 'package:ecommerce_store/screen/home/components/product_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Function oncallbackFuntion;
  const Body({
    Key? key,
    required this.controller,
    required this.scaleAnimation,
    required this.oncallbackFuntion,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isCollapsed = true;
  final Duration duration = const Duration(milliseconds: 300);

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
          borderRadius: BorderRadius.circular(isCollapsed ? 0 : 20),
          elevation: isCollapsed ? 0 : 5,
          color: kbackground,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 3),
                          margin: EdgeInsets.only(top: size.height * 0.055),
                          child: InkWell(
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
                            child: SvgPicture.asset(
                              'assets/icons/menu.svg',
                              width: 16,
                              height: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SearchBar(borderColor: Colors.grey),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: const Text(
                      'Order online collect in store',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  const CategoryBuilder(),
                  const Items(),
                  SizedBox(height: size.height * 0.02),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'see more',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            color: kPrimary,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: kPrimary,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
