import 'package:ecommerce_store/services/authservice/iauth_service.dart';
import 'package:ecommerce_store/utility/sharedconstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices implements IAuthService {
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
}
