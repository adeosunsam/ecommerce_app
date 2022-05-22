import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/user.dart';
import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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
  bool isLoading = false;
  File? avatarImageFile;
  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? getImage = await imagePicker
        .pickImage(source: ImageSource.gallery)
        .catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
    File? image;
    if (getImage != null) {
      image = File(getImage.path);
    }
    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
      uploadImage();
    }
  }

  Future uploadImage() async {
    final getUser = await AuthProvider.fromapi().currentUser;
    // final token =
    //     await AuthProvider.fromapi().getSharedPref(key: SharedConstants.token);
    try {
      var stream = avatarImageFile!.readAsBytes().asStream();

      var length = avatarImageFile!.lengthSync();

      var url = Uri.parse(
          'https://restaurantbookingapi.herokuapp.com/api/v1/Gadget/add-image');
      var request = http.MultipartRequest('POST', url);
      request.fields['Id'] = getUser!.data.id;
      Map<String, String> headers = {"Content-type": "multipart/form-data"};
      var multiport = http.MultipartFile(
        'image',
        stream,
        length,
        filename: avatarImageFile!.path.split('/').last,
      );

      request.files.add(multiport);
      request.headers.addAll(headers);
      request.send().then((response) async {
        if (response.statusCode == 200) {
          var responseData = await response.stream.toBytes();
          var responseString = String.fromCharCodes(responseData);
          var user = userTokenFromJson(responseString);
          if (user.succeeded) {
            final userJson = await AuthProvider.fromapi()
                .getSharedPref(key: SharedConstants.user);
            if (userJson != null) {
              final userData = userFromJson(userJson);
              userData.data.avatar = user.data;
              AuthProvider.fromapi().setSharedPref(
                  key: SharedConstants.user, value: jsonEncode(userData));
            }
            Fluttertoast.showToast(
              msg: user.message,
              backgroundColor: Colors.grey,
            );
          } else {
            Fluttertoast.showToast(
              msg: user.message,
              backgroundColor: Colors.grey,
            );
          }
          widget.callbackFunction();
        }
      });
    } catch (_) {
      Fluttertoast.showToast(
        msg: "Unable to upload file, try again",
        backgroundColor: Colors.grey,
      );
    }
  }

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
              onPressed: getImage,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: avatarImageFile == null
                    ? widget.userdata.avatar != null
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
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
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
                            size: 75,
                            color: kPrimary,
                          )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.network(
                          widget.userdata.avatar,
                          fit: BoxFit.cover,
                          width: 75,
                          height: 75,
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
