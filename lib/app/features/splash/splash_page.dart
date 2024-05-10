import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:puc_minas/app/core/constants/app_assets.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppAssets.logo).animate().fade(
                  begin: 0,
                  end: 1,
                  duration: 2.seconds,
                ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var sp = await SharedPreferences.getInstance();
                var result = sp.get('cpf');
                if (result == null) {
                  Navigator.of(context).pushNamed(
                    AppRoutes.login,
                  );
                } else {
                  Navigator.of(context).pushNamed(
                    AppRoutes.home,
                  );
                }
              },
              child: const Text('ENTRAR'),
            )
          ],
        ),
      ),
    );
  }
}
