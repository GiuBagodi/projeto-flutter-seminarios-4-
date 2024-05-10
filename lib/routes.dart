import 'package:flutter/material.dart';
import 'package:puc_minas/app/core/constants/app_routes.dart';
import 'package:puc_minas/app/features/home/home_page.dart';
import 'package:puc_minas/app/features/login/login_page.dart';
import 'package:puc_minas/app/features/products/add_product_page.dart';
import 'package:puc_minas/app/features/splash/splash_page.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.splash: (context) => const SplashPage(),
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.login: (context) => const LoginPage(),
    AppRoutes.add: (context) => const AddProductPage(),
  };
}
