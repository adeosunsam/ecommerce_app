import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/login/login_screen.dart';
import 'package:ecommerce_store/screen/sidebar/components/sidebar_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideBarScreen extends StatelessWidget {
  final Animation<Offset> sideAnimation;
  const SideBarScreen({
    Key? key,
    required this.sideAnimation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SlideTransition(
        position: sideAnimation,
        child: const Page(),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * .1),
            child: Stack(
              children: [
                const SidebarMenu(),
                Positioned(
                  bottom: size.height * .05,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/logout.svg',
                        color: Colors.white,
                        width: 18,
                      ),
                      SizedBox(width: size.width * .025),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        child: const Text(
                          'Sign out',
                          style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.14,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 126, 124, 242),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.24,
                  left: size.width * 0.3,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 126, 124, 242),
                        width: 4,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.08,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromARGB(255, 126, 124, 242),
                        width: 4,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * -0.065,
                  right: 10,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 126, 124, 242),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.2,
            right: 0,
            child: Container(
              width: size.width * .455,
              height: size.height * 0.6,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 126, 124, 242),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
