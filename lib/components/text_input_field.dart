import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final String hintText;

  const InputTextField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  late final TextEditingController _text;

  @override
  void initState() {
    _text = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      enableSuggestions: false,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      style: const TextStyle(
        fontSize: 20,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w600,
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
