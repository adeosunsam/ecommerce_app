import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Color borderColor;
  const SearchBar({
    Key? key,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.04),
        height: size.height * 0.065,
        width: size.width * 0.65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            width: 1,
            color: borderColor,
          ),
        ),
        child: TextField(
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Image.asset(
                'assets/images/search.png',
                scale: 2.3,
                color: const Color.fromARGB(255, 90, 89, 89),
              ),
            ),
            hintText: 'Search',
            border: InputBorder.none,
          ),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Raleway',
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
