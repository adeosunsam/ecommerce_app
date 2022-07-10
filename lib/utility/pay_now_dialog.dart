import 'package:ecommerce_store/entity/products.dart';
import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/screen/cart/components/cart_total.dart';
import 'package:ecommerce_store/screen/home/home_page.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:io';

Future showPayNowDialog(
  BuildContext context,
  PaystackPlugin _plugin,
  int totalQuantity,
) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (_) => Material(
            type: MaterialType.transparency,
            child: Container(
              margin: EdgeInsets.only(top: size.height * .4),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .35,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * .1,
                            vertical: size.height * .05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Confirm and pay',
                                style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    'products: ',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '$totalQuantity',
                                    style: const TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  CartTotalPrice(
                    text: 'Pay now',
                    press: () => _handleCheckout(context, _plugin),
                  ),
                ],
              ),
            ),
          ));
}

String backendUrl = 'https://paystackapi.herokuapp.com/';
// Set this to a public key that matches the secret key you supplied while creating the heroku instance
//String paystackPublicKey = 'pk_test_4dbac798af1acd95a84e6201dd22978806d1a891';
const String appName = 'Paystack Example';

final _formKey = GlobalKey<FormState>();
var plugin = PaystackPlugin();
int _radioValue = 0;
CheckoutMethod _method = CheckoutMethod.card;
String? _cardNumber;
String? _cvv;
int? _expiryMonth;
int? _expiryYear;

_handleCheckout(BuildContext context, PaystackPlugin _plugin) async {
  if (_method != CheckoutMethod.card && _isLocal) {
    return;
  }
  plugin = _plugin;
  int price = 0;
  Data user = Data(
    id: "",
    firstName: '',
    lastName: '',
    avatar: '',
    email: '',
    address: '',
    phoneNumber: '',
  );
  UserData? getUser = await AuthProvider.fromapi().currentUser;
  if (getUser != null) {
    user = getUser.data;
  }
  final cartList =
      await AuthProvider.fromapi().getSharedPref(key: SharedConstants.cart);
  if (cartList != null) {
    final productList = gadgetFromJson(cartList);
    price = productList
        .fold<double>(0, (a, b) => a + (b.quantity * b.price))
        .toInt();
  }
  //setState(() => _inProgress = true);
  _formKey.currentState?.save();
  Charge charge = Charge()
    ..amount = price * 382 * 100 // In base currency
    ..email = user.email
    ..card = _getCardFromUI();

  if (!_isLocal) {
    var accessCode = await _fetchAccessCodeFrmServer(_getReference());
    charge.accessCode = accessCode;
  } else {
    charge.reference = _getReference();
  }

  try {
    CheckoutResponse response = await plugin.checkout(
      context,
      method: _method,
      charge: charge,
      fullscreen: false,
      logo: const MyLogo(),
    );
    if (response.status) {
      AuthProvider.fromapi().removePref(key: SharedConstants.cart);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductPage(),
          ));
      //Navigator.of(context).pop();
    }
    //setState(() => _inProgress = false);
  } catch (e) {
    //setState(() => _inProgress = false);
    rethrow;
  }
}

_startAfreshCharge(BuildContext context, PaystackPlugin _plugin) async {
  _formKey.currentState?.save();

  Charge charge = Charge();
  charge.card = _getCardFromUI();

  //setState(() => _inProgress = true);

  if (_isLocal) {
    charge
      ..amount = 10000 // In base currency
      ..email = 'customer@email.com'
      ..reference = _getReference()
      ..putCustomField('Charged From', 'Flutter SDK');
    _chargeCard(context, charge, _plugin);
  } else {
    charge.accessCode = await _fetchAccessCodeFrmServer(_getReference());
    _chargeCard(context, charge, _plugin);
  }
}

_chargeCard(
  BuildContext context,
  Charge charge,
  PaystackPlugin _plugin,
) async {
  plugin = _plugin;
  final response = await plugin.chargeCard(context, charge: charge);

  final reference = response.reference;

  // Checking if the transaction is successful
  if (response.status) {
    _verifyOnServer(reference);
    return;
  }

  // The transaction failed. Checking if we should verify the transaction
  if (response.verify) {
    _verifyOnServer(reference);
  } else {
    //setState(() => _inProgress = false);
  }
}

String _getReference() {
  String platform;
  if (Platform.isIOS) {
    platform = 'iOS';
  } else {
    platform = 'Android';
  }

  return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
}

PaymentCard _getCardFromUI() {
  return PaymentCard(
    number: _cardNumber,
    cvc: _cvv,
    expiryMonth: _expiryMonth,
    expiryYear: _expiryYear,
  );
}

// Widget _getPlatformButton(String string, Function function) {
//   // is still in progress
//   Widget widget;
//   if (Platform.isIOS) {
//     widget = CupertinoButton(
//       onPressed: function,
//       padding: const EdgeInsets.symmetric(horizontal: 15.0),
//       color: CupertinoColors.activeBlue,
//       child: Text(
//         string,
//         maxLines: 1,
//         overflow: TextOverflow.ellipsis,
//       ),
//     );
//   } else {
//     widget = ElevatedButton(
//       onPressed: function,
//       child: Text(
//         string.toUpperCase(),
//         style: const TextStyle(fontSize: 17.0),
//       ),
//     );
//   }
//   return widget;
// }

Future<String?> _fetchAccessCodeFrmServer(String reference) async {
  String url = '$backendUrl/new-access-code';
  String? accessCode;
  try {
    http.Response response = await http.get(Uri.parse(url));
    accessCode = response.body;
  } catch (e) {
    //setState(() => _inProgress = false);
    rethrow;
  }

  return accessCode;
}

void _verifyOnServer(String? reference) async {
  String url = '$backendUrl/verify/$reference';
  try {
    await http.get(Uri.parse(url));
  } catch (e) {
    rethrow;
  }
  //setState(() => _inProgress = false);
}

bool get _isLocal => _radioValue == 0;

class MyLogo extends StatelessWidget {
  const MyLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: const Text(
        "SA",
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

const Color green = Color(0xFF3db76d);
const Color lightBlue = Color(0xFF34a5db);
const Color navyBlue = Color(0xFF031b33);
