import 'dart:convert';

UserData userFromJson(String str) => UserData.fromJson(json.decode(str));

String userToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.statusCode,
  });

  Data data;
  bool succeeded;
  String message;
  int statusCode;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        data: Data.fromJson(json["data"]),
        succeeded: json["succeeded"],
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "succeeded": succeeded,
        "message": message,
        "statusCode": statusCode,
      };
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.email,
    required this.address,
    required this.phoneNumber,
  });

  String id;
  String firstName;
  String lastName;
  dynamic avatar;
  String email;
  String address;
  String phoneNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        avatar: json["avatar"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "avatar": avatar,
        "email": email,
        "address": address,
        "phoneNumber": phoneNumber,
      };
}
