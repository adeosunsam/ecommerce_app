import 'package:ecommerce_store/constants.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * .03),
          width: size.width * .8,
          child: const Text(
            'Payment Method',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          height: size.height * .2,
          width: size.width * .8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: const PaymentProvider(),
        ),
      ],
    );
  }
}

class PaymentProvider extends StatefulWidget {
  const PaymentProvider({Key? key}) : super(key: key);

  @override
  State<PaymentProvider> createState() => _PaymentProviderState();
}

List<String> paymentGateway = ['paystack', 'paypal'];
int _selectedIndex = 0;

class _PaymentProviderState extends State<PaymentProvider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: paymentGateway
            .map(
              (e) => _getPaymentGateway(e, paymentGateway.indexOf(e)),
            )
            .toList(),
      ),
    );
  }

  Widget _getPaymentGateway(String gateway, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              height: 18,
              width: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      (_selectedIndex == index) ? kPrimary : Colors.transparent,
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (_selectedIndex == index)
                      ? kPrimary
                      : const Color(0xFFC4C4C4),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Image.asset(
              'assets/images/$gateway.png',
              scale: 8,
            ),
          ],
        ),
      ),
    );
  }
}
