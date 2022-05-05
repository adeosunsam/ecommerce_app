import 'dart:convert';

User userTokenFromJson(String str) => User.fromJson(json.decode(str));

class User {
  User({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.statusCode,
  });

  dynamic data;
  bool succeeded;
  String message;
  int statusCode;

  factory User.fromJson(Map<String, dynamic> json) => User(
        data: json["data"],
        succeeded: json["succeeded"],
        message: json["message"],
        statusCode: json["statusCode"],
      );
}
