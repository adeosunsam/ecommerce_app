import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? text;

  const InputTextField({
    Key? key,
    required this.hintText,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: text,
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w500,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
