import 'package:ecommerce_store/constants.dart';
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
    return Padding(
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
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.callbackFunction(_selectedIndex);
  }
}
