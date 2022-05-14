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
  bool click = true;

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
