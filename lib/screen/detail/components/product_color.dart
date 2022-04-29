import 'package:flutter/material.dart';

class ProductColor extends StatefulWidget {
  const ProductColor({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductColor> createState() => _ProductColorState();
}

int _selectedIndex = 0;
List<String> colors = ['Sky Blue', 'Rose Gold', 'Green'];
List<String> colorCodes = ['7485C1', 'C9A19C', 'A1C89B'];

class _ProductColorState extends State<ProductColor> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: colors.map(
        (e) {
          final colorCode = int.parse('0xFF${colorCodes[colors.indexOf(e)]}');
          return getColor(e, Color(colorCode), colors.indexOf(e));
        },
      ).toList(),
    );
  }

  Widget getColor(String text, Color innerColor, int currentIndex) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = currentIndex;
        });
      },
      child: Container(
        height: size.height * 0.06,
        width: size.width * 0.25,
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedIndex == currentIndex
                ? Colors.grey
                : const Color(0xFFE3E3E3),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 15,
              width: 15,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.transparent),
                shape: BoxShape.circle,
                color: innerColor,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
