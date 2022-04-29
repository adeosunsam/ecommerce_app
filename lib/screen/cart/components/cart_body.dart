import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/screen/cart/components/set_quantity.dart';
import 'package:flutter/material.dart';

class CartBody extends StatefulWidget {
  final Product cartproduct;
  final Function onCallBack;
  const CartBody({
    Key? key,
    required this.cartproduct,
    required this.onCallBack,
  }) : super(key: key);

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  callback(int value) {
    setState(() {
      if (value == -1 && widget.cartproduct.quantity == 1) {
        widget.cartproduct.quantity = widget.cartproduct.quantity;
      } else if (value == -1) {
        widget.cartproduct.quantity += value;
        widget.cartproduct.total -= widget.cartproduct.price;
      } else if (value == 1) {
        widget.cartproduct.quantity += value;
        widget.cartproduct.total += widget.cartproduct.price;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.width * .1,
        vertical: size.height * .01,
      ),
      height: size.height * .17,
      width: size.width * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.cartproduct.image,
              height: size.height * .23,
              width: size.width * .23,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * .02),
                    Text(
                      widget.cartproduct.title,
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: size.height * .018),
                    Text(
                      '\$${widget.cartproduct.total}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        color: kPrimary,
                      ),
                    ),
                    SizedBox(height: size.height * .016),
                    Row(
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Raleway',
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: size.width * .02),
                        Quantity(
                          oncallTotalPrice: widget.onCallBack,
                          oncallBackFunction: callback,
                          icon: Icons.remove,
                        ),
                        SizedBox(width: size.width * .02),
                        Text(
                          '${widget.cartproduct.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Raleway',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: size.width * .02),
                        Quantity(
                          oncallTotalPrice: widget.onCallBack,
                          oncallBackFunction: callback,
                          icon: Icons.add,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
