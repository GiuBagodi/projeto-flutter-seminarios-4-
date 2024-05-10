import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  static Future<bool> login({
    required String cpf,
    required String password,
  }) async {
    await Future.delayed(2.seconds);
    if (cpf == '51125173874' && password == '123456') {
      var sp = await SharedPreferences.getInstance();

      await sp.setString('cpf', cpf);

      return true;
    }
    return false;
  }
}
