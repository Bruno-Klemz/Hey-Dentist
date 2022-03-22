import 'package:flutter/material.dart';
import 'package:hey_dentist/Login/View/LoginView.dart';

class AppRouter {
  static Route? navigate(RouteSettings settings) {
    switch (settings.name) {
      case 'initialRoute':
        return MaterialPageRoute(builder: (_) => LoginPage());


      default:
        return null;
    }
  }
}
