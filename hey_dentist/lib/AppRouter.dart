import 'package:flutter/material.dart';
import 'package:hey_dentist/Login/View/LoginView.dart';
import 'package:hey_dentist/Register/View/RegisterView.dart';

import 'HomePage/View/HomePageView.dart';
import 'RegisterPatient/View/RegisterPatientView.dart';

class AppRouter {
  static Route? navigate(RouteSettings settings) {
    switch (settings.name) {
      case 'initialRoute':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case 'LoginScreenToRegisterScreen':
        return MaterialPageRoute(builder: (_) => RegisterPage());

      case 'LoginScreenToHomeScreen':
        return MaterialPageRoute(builder: (_) => HomePage());

      case 'RegisterScreenToHomeScreen':
        return MaterialPageRoute(builder: (_) => HomePage());

      case 'HomeToRegisterPatient':
        return MaterialPageRoute(builder: (_) => RegisterPatient());
      default:
        return null;
    }
  }
}
