import 'package:ecommerce_store/utility/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showPresentInCartDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: 'Completed',
    content: 'Item is already present in your cart!',
    optionBuilder: () => {},
  ).then((value) => value ?? false);
}
