import 'package:ecommerce_store/entity/user.dart';
import 'package:ecommerce_store/entity/userdata.dart';

abstract class IAuthService {
  Future<String?> getSharedPref({required String key});
  Future setSharedPref({required String key, required String value});
  Future removePref({required String key});
  Future logOut();
  Future<User> logIn({required String email, required String password});
  Future<UserData?> get currentUser;
}
