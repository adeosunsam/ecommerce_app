import 'package:ecommerce_store/constants.dart';
import 'package:flutter/material.dart';

class Quantity extends StatelessWidget {
  final Function oncallBackFunction;
  final Function oncallTotalPrice;
  final IconData icon;
  const Quantity({
    Key? key,
    required this.icon,
    required this.oncallBackFunction,
    required this.oncallTotalPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (icon == Icons.remove) {
          oncallBackFunction(-1);
        } else {
          oncallBackFunction(1);
        }
        oncallTotalPrice();
      },
      child: Container(
        height: 19,
        width: 19,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4), color: kPrimary),
        child: Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
