import 'package:flutter/material.dart';
import 'package:hey_dentist/Data/Dentist/UserModel.dart';
import 'package:hey_dentist/Login/View/LoginView.dart';
import 'package:hey_dentist/Register/View/RegisterView.dart';
import 'package:hey_dentist/RegisterAppointment/View/RegisterAppointmentView.dart';

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
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => HomePage(user: user));

      case 'RegisterScreenToHomeScreen':
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => HomePage(user: user));

      case 'HomeToRegisterPatient':
        return MaterialPageRoute(builder: (_) => const RegisterPatient());

      case 'HomeToRegisterAppointment':
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (_) => RegisterAppointment(user: user));

      case 'RegisterAppointmentToHome':
        final user = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (_) => HomePage(user: user));
      default:
        return null;
    }
  }
}
