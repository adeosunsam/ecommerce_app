import 'package:ecommerce_store/constants.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatefulWidget {
  final String imageSet;
  const ProductImage({
    Key? key,
    required this.imageSet,
  }) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

List<String> imageurl = [
  '',
  'assets/images/product2.png',
  'assets/images/start.png',
];
int _selectedIndex = 0;
String path = imageurl[0];

class _ProductImageState extends State<ProductImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: size.width * 0.48,
          height: size.height * 0.29,
          child: Column(
            children: [
              Image.network(
                widget.imageSet,
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageurl.map((e) {
            return productimage(imageurl.indexOf(e));
          }).toList(),
        ),
      ],
    );
  }

  Widget productimage(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          path = imageurl[_selectedIndex];
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        padding: const EdgeInsets.all(2),
        height: 15,
        width: 15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: (_selectedIndex == index) ? kPrimary : Colors.transparent,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                (_selectedIndex == index) ? kPrimary : const Color(0xFFC4C4C4),
          ),
        ),
      ),
    );
  }
}
