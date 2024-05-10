import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController {
  static Future<bool> login({
    required String cpf,
    required String password,
  }) async {
    await Future.delayed(2.seconds);

      var sp = await SharedPreferences.getInstance();

      await sp.setString('cpf', cpf);

      return true;

    
  }
}
