import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/checkout/components/shipping_info_detail.dart';
import 'package:ecommerce_store/screen/profile/components/edit_profile.dart';
import 'package:flutter/material.dart';

class ShippingInformation extends StatelessWidget {
  const ShippingInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: size.height * .03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Shipping information',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Shoppingaddress(),
                  ),
                ),
                child: const Text(
                  'change',
                  style: TextStyle(
                    color: kPrimary,
                    fontFamily: 'Raleway',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: size.height * .2,
          width: size.width * .8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ShippingInfoDetail(
                    imagePath: 'assets/icons/user.svg', text: 'Rosina Doe'),
                ShippingInfoDetail(
                  imagePath: 'assets/icons/location.svg',
                  text: "43 Oxford Road M13 4GR Manchester, UK",
                ),
                ShippingInfoDetail(
                    imagePath: 'assets/icons/call.svg',
                    text: '+234 8165434179'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
