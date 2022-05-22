import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/screen/profile/components/user_page_option.dart';
import 'package:ecommerce_store/screen/profile/components/user_profile.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
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

  callback() {
    setState(() {});
  }

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
          child: FutureBuilder(
              future: AuthProvider.fromapi().currentUser,
              builder: (context, snapshot) {
                Data currentUser = Data(
                  address: '',
                  avatar: null,
                  email: '',
                  firstName: '',
                  id: '',
                  lastName: '',
                  phoneNumber: '',
                );
                if (snapshot.hasData) {
                  final getuser = snapshot.data as UserData;
                  currentUser = getuser.data;
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                          ),
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
                                margin: EdgeInsets.symmetric(
                                    horizontal: size.width * .2),
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
                        UserProfile(
                          callbackFunction: callback,
                          userdata: currentUser,
                        ),
                        SizedBox(
                          height: size.height * .535,
                          child: const UserPageOptions(),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: kPrimary,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
