import 'package:ecommerce_store/utility/generic_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<void> showAddedToCartDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: 'Completed',
    content: 'Item has been successfully added to your cart!',
    optionBuilder: () => {},
  ).then((value) => value ?? false);
}
