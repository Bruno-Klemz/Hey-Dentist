import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Login/BLoC/LoginBloc.dart';
import 'package:hey_dentist/Login/BLoC/LoginState.dart';
import 'package:hey_dentist/Login/Navigator/LoginNavigator.dart';
import 'package:hey_dentist/Register/BLoC/RegisterBloc.dart';

import 'Auth/auth.dart';
import 'Register/BLoC/RegisterState.dart';
import 'Register/Navigator/RegisterNavigator.dart';

class AppBlocProvider {
  List<BlocProvider> getAppBlocProvider() {
    List<BlocProvider> blocProviderList = [
      BlocProvider<LoginBloc>(
          create: (BuildContext context) =>
              LoginBloc(LoginInitialState(), Auth(), LoginNavigator())),

      BlocProvider<RegisterBloc>(
          create: (BuildContext context) =>
              RegisterBloc(RegisterInitialState(), Auth(), RegisterNavigator())),

      
    ];
    return blocProviderList;
  }
}
