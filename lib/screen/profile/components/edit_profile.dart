import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Page'),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

class Shoppingaddress extends StatelessWidget {
  const Shoppingaddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Address Page'),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

class Orderhistory extends StatelessWidget {
  const Orderhistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History Page'),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

class Cards extends StatelessWidget {
  const Cards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Page'),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Page'),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}
