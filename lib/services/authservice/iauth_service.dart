abstract class IAuthService {
  Future<String?> getSharedPref({required String key});
  Future setSharedPref({required String key, required String value});
  Future logOut();
}
