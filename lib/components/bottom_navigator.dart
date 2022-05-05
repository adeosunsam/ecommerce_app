import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/cart_product.dart';
import 'package:ecommerce_store/screen/login/login_screen.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  _onItemTapped(int index) async {
    final userPrefs =
        await AuthProvider.fromapi().getSharedPref(key: SharedConstants.user);
    setState(() {
      _selectedIndex = index;
    });
    if (userPrefs == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
    widget.callbackFunction(_selectedIndex);
  }
}
