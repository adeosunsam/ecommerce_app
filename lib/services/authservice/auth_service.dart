import 'dart:io';

import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/entity/user.dart';
import 'package:ecommerce_store/services/authservice/genericHttpRequest/httprequesthandler.dart';
import 'package:ecommerce_store/services/authservice/iauth_service.dart';
import 'package:ecommerce_store/utility/exception.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices implements IAuthService {
  Map<String, dynamic> toJson({
    firstName,
    lastName,
    required email,
    address,
    required password,
  }) =>
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'address': address,
        'password': password
      };

  @override
  Future<String?> getSharedPref({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future setSharedPref({
    required String key,
    required String value,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  @override
  Future logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedConstants.user);
  }

  @override
  Future<UserData?> get currentUser async {
    final prefs = await SharedPreferences.getInstance();
    var result = prefs.getString(SharedConstants.user);
    return result != null ? userFromJson(result) : null;
  }

  @override
  Future<User> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final response =
          await apiRequest('/Authentication/Login', RequestMethod.post,
              body: toJson(
                email: email,
                password: password,
              ));
      final token = userTokenFromJson(response);
      if (token.data == null) {
        throw InvalidLoginCredential();
      }
      setSharedPref(
        key: SharedConstants.token,
        value: token.data,
      );
      await _setUserToSharedPreference();
      return token;
    } on SocketException catch (_) {
      throw BadOrNoNetworkException();
    } on InvalidLoginCredential catch (_) {
      throw InvalidLoginCredential();
    } catch (_) {
      throw GenericAuthException();
    }
  }

  Future _setUserToSharedPreference() async {
    final token = await getSharedPref(key: SharedConstants.token);
    if (token == null) {
      return;
    } else {
      final response = await apiRequest(
        '/User/current-user',
        RequestMethod.get,
        token: token,
      );

      // obtain shared preferences
      final prefs = await SharedPreferences.getInstance();

      // set value
      prefs.setString(SharedConstants.user, response);
    }
  }
}
