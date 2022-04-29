import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback press;
  final Color buttonColor;
  final Color textColor;
  final String text;
  const RoundedButton({
    Key? key,
    required this.press,
    required this.buttonColor,
    required this.textColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 55,
      width: size.width * 0.8,
      child: ElevatedButton(
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
            //elevation: 0,
            primary: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
      ),
    );
  }
}
