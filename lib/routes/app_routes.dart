import 'package:flutter/widgets.dart' show Widget, BuildContext;
import 'package:reposteria_catra/pages/home/home_page.dart';
import 'package:reposteria_catra/pages/login/login_page.dart';
import 'package:reposteria_catra/pages/payment/payment_page.dart';
import 'package:reposteria_catra/pages/register/register_page.dart';
import 'package:reposteria_catra/pages/splash/splash_page.dart';
import 'package:reposteria_catra/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRutas => {
    Rutas.SPLASH: (_) => const SplashPage(),
    Rutas.HOME: (_) => const HomePage(),
    Rutas.LOGIN: (_) => const LoginPage(),
    Rutas.REGISTER: (_) => const RegisterPage(),
    Rutas.PAYMENT: (_) => const PaymentPage(),
};