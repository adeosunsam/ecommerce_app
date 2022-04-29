import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final Image errorImage;
  final String title;
  final VoidCallback press;
  const EmptyScreen({
    Key? key,
    required this.errorImage,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * .1),
      child: Column(
        children: [
          errorImage,
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              fontSize: 21,
              color: Colors.black,
            ),
          ),
          SizedBox(height: size.height * .03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * .18),
            child: const Text(
              'Hit the button down below to Create an order.',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SizedBox(height: size.height * .03),
          SizedBox(
            height: 40,
            width: size.width * 0.5,
            child: ElevatedButton(
              onPressed: press,
              child: const Text(
                'Start ordering',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: const Color(0xFF58C0EA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
