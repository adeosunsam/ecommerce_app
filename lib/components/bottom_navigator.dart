import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigator extends StatefulWidget {
  final Function callbackFunction;
  final int index;
  const BottomNavigator({
    Key? key,
    required this.callbackFunction,
    required this.index,
  }) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

final List<String> _bottomNav = ['home', 'heart', 'user', 'cart'];

List<CartProduct> getCartProducts = [];
//int _selectedIndex = 0;

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    onload() async {
      final cartList =
          await AuthProvider.fromapi().getSharedPref(key: SharedConstants.cart);
      if (cartList != null) {
        final productList = gadgetFromJson(cartList);
        getCartProducts = productList;
      } else {
        getCartProducts = [];
      }
    }

    return FutureBuilder(
        future: onload(),
        builder: (context, snapshot) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BottomNavigationBar(
                  currentIndex: widget.index,
                  elevation: 0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  selectedItemColor: kPrimary,
                  backgroundColor: kbackground,
                  type: BottomNavigationBarType.fixed,
                  items: _bottomNav
                      .map(
                        (e) => BottomNavigationBarItem(
                          label: e,
                          icon: SvgPicture.asset(
                            'assets/icons/$e.svg',
                          ),
                          activeIcon: SvgPicture.asset(
                            'assets/icons/$e.svg',
                            color: kPrimary,
                          ),
                          backgroundColor: kPrimary,
                        ),
                      )
                      .toList(),
                  onTap: _onItemTapped,
                ),
              ),
              getCartProducts.isNotEmpty
                  ? Positioned(
                      right: getCartProducts.length > 9 ? 40 : 43,
                      bottom: getCartProducts.length > 9 ? 27 : 25,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                              getCartProducts.length > 9 ? 2 : 4),
                          child: Text(
                            '${getCartProducts.length}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : const Padding(padding: EdgeInsets.zero),
            ],
          );
        });
  }

  _onItemTapped(int index) async {
    if (widget.index == index) {
      return;
    }
    widget.callbackFunction(index);
  }
}
