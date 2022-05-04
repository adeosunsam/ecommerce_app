import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/cart_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigator extends StatefulWidget {
  final Function callbackFunction;
  const BottomNavigator({
    Key? key,
    required this.callbackFunction,
  }) : super(key: key);

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

int _selectedIndex = 0;
final List<String> _bottomNav = ['Home', 'heart', 'user', 'cart'];

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
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
                      color: _selectedIndex == _bottomNav.indexOf(e)
                          ? kPrimary
                          : Colors.black,
                    ),
                  ),
                )
                .toList(),
            onTap: _onItemTapped,
          ),
        ),
        cartProducts.isNotEmpty
            ? Positioned(
                right: cartProducts.length > 9 ? 40 : 43,
                bottom: cartProducts.length > 9 ? 27 : 25,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: kPrimary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(cartProducts.length > 9 ? 2 : 4),
                    child: Text(
                      '${cartProducts.length}',
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
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.callbackFunction(_selectedIndex);
  }
}
