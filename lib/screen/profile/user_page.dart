import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/screen/profile/components/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserProfileScreen extends StatefulWidget {
  final AnimationController controller;
  final Animation<double> scaleAnimation;
  final Function oncallbackFuntion;
  const UserProfileScreen({
    Key? key,
    required this.controller,
    required this.scaleAnimation,
    required this.oncallbackFuntion,
  }) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isCollapsed = true;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.43 * size.width,
      right: isCollapsed ? 0 : -.4 * size.width,
      duration: duration,
      child: ScaleTransition(
        scale: widget.scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.circular(!isCollapsed ? 20 : 0),
          elevation: isCollapsed ? 0 : 5,
          color: kbackground,
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (isCollapsed) {
                                widget.controller.forward();
                              } else {
                                widget.controller.reverse();
                              }
                              isCollapsed = !isCollapsed;
                            });
                            widget.oncallbackFuntion(isCollapsed);
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * .05),
                            width: 22,
                            height: 22,
                            child: SvgPicture.asset(
                              'assets/icons/menu.svg',
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: size.width * .2),
                          child: const Text(
                            'My profile',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.1,
                      vertical: size.height * 0.02,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.18,
                          width: size.width * 0.8,
                          margin: EdgeInsets.only(top: size.height * 0.05),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.109,
                          width: size.height * 0.4,
                          child: FittedBox(
                            child: CircleAvatar(
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/user.jpeg',
                                  height: 90,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.12,
                          left: size.width * 0.31,
                          child: const Text(
                            'John Doe',
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.15,
                          left: size.width * .05,
                          child: SvgPicture.asset(
                            'assets/icons/location.svg',
                            width: 22,
                          ),
                        ),
                        Positioned(
                          width: size.height * 0.4,
                          top: size.height * 0.15,
                          left: size.width * .05,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.1),
                            child: const Text(
                              "Address: 43 Oxford Road M13 4GR Manchester, UK",
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const UserPageOptions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
    return Column(
      children: options.map((e) {
        int index = options.indexOf(e);
        return expandOption(e, index);
      }).toList(),
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
          ]),
        ),
      ),
    );
  }
}
