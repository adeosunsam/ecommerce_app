import 'package:ecommerce_store/constants.dart';
import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final String hintText;

  const PasswordInputField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
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
      autofocus: true,
      obscureText: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixStyle: const TextStyle(
          color: kPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 20,
          fontFamily: 'Raleway',
        ),
        suffixText: 'Show',
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
