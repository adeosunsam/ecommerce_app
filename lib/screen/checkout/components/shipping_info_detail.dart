import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShippingInfoDetail extends StatelessWidget {
  final String imagePath;
  final String text;
  const ShippingInfoDetail({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          child: SvgPicture.asset(
            imagePath,
            width: 22,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              text,
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
