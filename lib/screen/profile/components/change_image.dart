import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_store/constants.dart';
import 'package:ecommerce_store/entity/user.dart';
import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/services/authservice/auth_provider.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class EditImage extends StatefulWidget {
  final String imagePath;
  final Function onCallbackFunction;
  const EditImage({
    Key? key,
    required this.imagePath,
    required this.onCallbackFunction,
  }) : super(key: key);

  @override
  State<EditImage> createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
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
          widget.onCallbackFunction();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackground,
        foregroundColor: Colors.black,
        actions: [
          GestureDetector(
            onTap: getImage,
            child: const Icon(
              Icons.create_rounded,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: const Icon(
              Icons.camera_alt,
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: getImage,
        child: Center(
          heightFactor: size.height * .5,
          widthFactor: double.infinity,
          child: Hero(
            tag: 'imageHero',
            child: avatarImageFile == null
                ? widget.imagePath.isNotEmpty
                    ? Image.network(
                        widget.imagePath,
                        fit: BoxFit.cover,
                        height: size.height * .5,
                        width: size.width,
                        errorBuilder: (context, object, stackTrace) {
                          return const Icon(
                            Icons.account_circle,
                            color: kPrimary,
                          );
                        },
                        loadingBuilder: (context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            child: Container(
                              color: Colors.grey,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : const Icon(
                        Icons.person,
                      )
                : Image.file(
                    avatarImageFile!,
                    fit: BoxFit.cover,
                    height: size.height * .5,
                    width: size.width,
                  ),
          ),
        ),
      ),
    );
  }
}
