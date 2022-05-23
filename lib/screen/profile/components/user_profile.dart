import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/screen/profile/components/change_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserProfile extends StatefulWidget {
  final Function callbackFunction;
  final Data userdata;
  const UserProfile({
    Key? key,
    required this.userdata,
    required this.callbackFunction,
  }) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
        vertical: size.height * 0.01,
      ),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
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
          Positioned(
            top: size.height * -.05,
            child: CupertinoButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditImage(
                      onCallbackFunction: widget.callbackFunction,
                      imagePath: widget.userdata.avatar,
                    ),
                  )),
              child: Container(
                margin: const EdgeInsets.all(20),
                child: widget.userdata.avatar != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          widget.userdata.avatar,
                          fit: BoxFit.cover,
                          width: 75,
                          height: 75,
                          errorBuilder: (context, object, stackTrace) {
                            return const Icon(
                              Icons.account_circle,
                              size: 90,
                              color: kPrimary,
                            );
                          },
                          loadingBuilder: (context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return SizedBox(
                              width: 75,
                              height: 75,
                              child: Container(
                                color: Colors.grey,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Icon(
                        Icons.account_circle,
                        size: 90,
                      ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.12,
            child: Text(
              '${widget.userdata.firstName} ${widget.userdata.lastName}',
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
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
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Text(
                'Address: ${widget.userdata.address}',
                style: const TextStyle(
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
    );
  }
}
