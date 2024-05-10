import 'package:shared_preferences/shared_preferences.dart';

class HomeController {
  static Future<bool> logout() async {
    var sp = await SharedPreferences.getInstance();

    bool deleted = await sp.remove('cpf');

    return deleted;
  }
}
