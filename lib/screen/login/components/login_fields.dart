import 'package:ecommerce_store/components/password_input_field.dart';
import 'package:ecommerce_store/components/rounded_button.dart';
import 'package:ecommerce_store/components/text_input_field.dart';
import 'package:ecommerce_store/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginField extends StatefulWidget {
  const LoginField({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginField> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.42),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/email.svg',
                  width: 22,
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                const Text(
                  'Email',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            const InputTextField(hintText: 'sadeosun@gmail.com'),
            SizedBox(height: size.height * 0.04),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/lock.svg',
                  width: 22,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                const Text(
                  'Password',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            const PasswordInputField(hintText: 'Password'),
            SizedBox(height: size.height * 0.03),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'Forget Passcode?',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  color: kPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
                press: () {},
                buttonColor: kPrimary,
                textColor: Colors.white,
                text: 'Login'),
            SizedBox(height: size.height * 0.02),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.2),
              child: GestureDetector(
                onTap: () {},
                child: const Text(
                  'Create account',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 20,
                    color: kPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
