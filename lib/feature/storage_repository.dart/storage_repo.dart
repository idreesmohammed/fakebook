import 'package:fakebook_posts/feature/signin/util/signin_page_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  setLoginInfo({required String name}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return await prefs.setString(SignInPageUtils.storageToken, name);
    } catch (e) {
      throw Exception(e);
    }
  }

  getLoginInfo() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(SignInPageUtils.storageToken);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> checkIfUserExists() async {
    final prefs = await SharedPreferences.getInstance();
    final isUserAvailable = prefs.containsKey('userInfo');
    if (isUserAvailable) {
      return true;
    } else {
      return false;
    }
  }

  Future removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userInfo');
  }
}
