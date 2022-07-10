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
  'assets/images/start.png',
];
int _selectedIndex = 0;

class _ProductImageState extends State<ProductImage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: size.height * 0.25,
          child: PageView(
            controller: _pageController,
            onPageChanged: (page) {
              setState(() {
                _selectedIndex = page;
              });
            },
            children: [
              for (int i = 0; i < imageurl.length; i++)
                Image.network(
                  widget.imageSet,
                ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageurl.map((e) {
              return productimage(imageurl.indexOf(e));
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget productimage(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
          _pageController.jumpToPage(index);
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
