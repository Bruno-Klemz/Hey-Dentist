import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Dentist/DentistAPI.dart';
import 'package:hey_dentist/Data/Dentist/DentistRepository.dart';
import 'package:hey_dentist/Login/BLoC/LoginBloc.dart';
import 'package:hey_dentist/Login/BLoC/LoginState.dart';
import 'package:hey_dentist/Login/Navigator/LoginNavigator.dart';
import 'package:hey_dentist/Register/BLoC/RegisterBloc.dart';

import 'Auth/auth.dart';
import 'HomePage/BLoC/HomePageBloc.dart';
import 'HomePage/BLoC/HomePageState.dart';
import 'HomePage/Navigator/HomePageNavigator.dart';
import 'Register/BLoC/RegisterState.dart';
import 'Register/Navigator/RegisterNavigator.dart';

class AppBlocProvider {
  List<BlocProvider> getAppBlocProvider() {
    List<BlocProvider> blocProviderList = [
      BlocProvider<LoginBloc>(
          create: (BuildContext context) =>
              LoginBloc(LoginInitialState(), Auth(), LoginNavigator())),
      BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(
              RegisterInitialState(),
              Auth(),
              RegisterNavigator(),
              DentistRepository(api: DentistAPI()))),

      BlocProvider<HomePageBloc>(
          create: (BuildContext context) =>
              HomePageBloc(HomePageInitialState(), HomePageNavigator())),
    ];
    return blocProviderList;
  }
}
