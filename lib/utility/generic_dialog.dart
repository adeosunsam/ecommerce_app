import 'package:ecommerce_store/constants.dart';
import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  String? title,
  required String content,
  required DialogOptionBuilder optionBuilder,
}) {
  Size size = MediaQuery.of(context).size;
  final options = optionBuilder();
  return showDialog<T>(
    context: context,
    builder: (context) {
      // Future.delayed(const Duration(milliseconds: 2500), () {
      //   Navigator.of(context).pop();
      // });
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        //actionsAlignment: MainAxisAlignment.center,
        insetPadding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        title: Text(
          title ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              value != null
                  ? Navigator.of(context).pop(value)
                  : Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Text(
              optionTitle,
              style: const TextStyle(
                color: kPrimary,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        }).toList(),
      );
    },
  );
}
