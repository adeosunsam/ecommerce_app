import 'package:ecommerce_store/entity/userdata.dart';
import 'package:ecommerce_store/entity/user.dart';
import 'package:ecommerce_store/services/authservice/auth_service.dart';
import 'package:ecommerce_store/services/authservice/iauth_service.dart';

class AuthProvider implements IAuthService {
  final IAuthService service;
  const AuthProvider(this.service);
  factory AuthProvider.fromapi() => AuthProvider(AuthServices());

  @override
  Future<String?> getSharedPref({required String key}) =>
      service.getSharedPref(key: key);

  @override
  Future setSharedPref({required String key, required String value}) =>
      service.setSharedPref(
        key: key,
        value: value,
      );

  @override
  Future logOut() => service.logOut();

  @override
  Future<UserData?> get currentUser => service.currentUser;

  @override
  Future<User> logIn({
    required String email,
    required String password,
  }) =>
      service.logIn(email: email, password: password);
}
