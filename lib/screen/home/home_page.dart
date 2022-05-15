import 'package:ecommerce_store/components/bottom_navigator.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/screen/cart/product_cart.dart';
import 'package:ecommerce_store/screen/favorite/fav_page.dart';
import 'package:ecommerce_store/screen/home/components/product.dart';
import 'package:ecommerce_store/screen/profile/user_page.dart';
import 'package:ecommerce_store/screen/sidebar/sidebar_view.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

late Animation<Offset> animation;
late AnimationController _controller;
late Animation<double> _scaleAnimation;

class _ProductPageState extends State<ProductPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _scaleAnimation = Tween<double>(begin: 1, end: 0.65).animate(_controller);
    animation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: const Offset(0, 0),
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int currentIndex = 0;
  Data _currentUser = Data(
    address: '',
    avatar: null,
    email: '',
    firstName: '',
    id: '',
    lastName: '',
    phoneNumber: '',
  );
  callback(int index, Data? currentUser) {
    setState(() {
      currentIndex = index;
      if (currentUser != null) {
        _currentUser = currentUser;
      }
    });
  }

  bool isClicked = true;
  oncallback(click) {
    setState(() {
      isClicked = click;
    });
  }

  deleteitemcallback() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List page = [
      Body(
          controller: _controller,
          scaleAnimation: _scaleAnimation,
          oncallbackFuntion: oncallback),
      FavoriteScreen(
          controller: _controller,
          scaleAnimation: _scaleAnimation,
          oncallbackFuntion: oncallback),
      UserProfileScreen(
          currentUser: _currentUser,
          controller: _controller,
          scaleAnimation: _scaleAnimation,
          oncallbackFuntion: oncallback),
      CartScreen(callbackFunction: deleteitemcallback),
    ];
    return Scaffold(
      backgroundColor: kbackground,
      body: Stack(
        children: [
          SideBarScreen(sideAnimation: animation),
          page[currentIndex],
        ],
      ),
      bottomNavigationBar: isClicked
          ? BottomNavigator(callbackFunction: callback)
          : const Padding(padding: EdgeInsets.zero),
    );
  }
}
