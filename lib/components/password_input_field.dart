import 'package:flutter/material.dart';

class PasswordInputField extends StatefulWidget {
  final String hintText;
  final TextEditingController? text;

  const PasswordInputField({
    Key? key,
    required this.hintText,
    required this.text,
  }) : super(key: key);

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool click = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.text,
      enableSuggestions: false,
      autocorrect: false,
      obscureText: click,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              click = !click;
            });
          },
          icon: Icon(
            click ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
