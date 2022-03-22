import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Login/BLoC/LoginBloc.dart';
import 'package:hey_dentist/Login/BLoC/LoginState.dart';

import 'Auth/auth.dart';

class AppBlocProvider {
  List<BlocProvider> getAppBlocProvider() {
    List<BlocProvider> blocProviderList = [
      BlocProvider<LoginBloc>(
          create: (BuildContext context) =>
              LoginBloc(LoginInitialState(), Auth())),

      
    ];
    return blocProviderList;
  }
}
