import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SidebarMenu extends StatelessWidget {
  const SidebarMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _menu = [
      'Profile',
      'My orders',
      'Favorites',
      'Delivery',
      'Settings',
    ];
    List icons = [
      'user',
      'cart',
      'heart',
      'bag',
      'setting',
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _menu.map((e) {
        int index = _menu.indexOf(e);
        return sidemenu(context, e, icons[index]);
      }).toList(),
    );
  }

  Widget sidemenu(
    BuildContext context,
    String menuItem,
    String icon,
  ) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/$icon.svg',
              color: Colors.white,
              width: 18,
            ),
            SizedBox(width: size.width * .025),
            Text(
              menuItem,
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * .03),
          child: Divider(
            color: menuItem != 'Settings'
                ? const Color.fromARGB(255, 167, 166, 243)
                : Colors.transparent,
            height: 5,
            endIndent: size.width * .4,
            indent: size.width * .08,
          ),
        ),
      ],
    );
  }
}
