import 'package:ecommerce_store/screen/profile/components/edit_profile.dart';
import 'package:flutter/material.dart';

class UserPageOptions extends StatefulWidget {
  const UserPageOptions({
    Key? key,
  }) : super(key: key);

  @override
  State<UserPageOptions> createState() => _UserPageOptionsState();
}

List<String> options = [
  'Edit Profile',
  'Shopping address',
  'Order history',
  'Cards',
  'Notifications'
];

List pages = [
  const EditProfile(),
  const Shoppingaddress(),
  const Orderhistory(),
  const Cards(),
  const Notifications(),
];

class _UserPageOptionsState extends State<UserPageOptions> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: options.map((e) {
          int index = options.indexOf(e);
          return expandOption(e, index);
        }).toList(),
      ),
    );
  }

  Widget expandOption(String option, int index) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pages[index]));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.1,
          vertical: size.width * 0.027,
        ),
        height: size.height * 0.08,
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 17,
              )
            ],
          ),
        ),
      ),
    );
  }
}
