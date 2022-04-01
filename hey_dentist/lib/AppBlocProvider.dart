import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentAPI.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentRepository.dart';
import 'package:hey_dentist/Data/Dentist/UserAPI.dart';
import 'package:hey_dentist/Data/Dentist/UserRepository.dart';
import 'package:hey_dentist/Login/BLoC/LoginBloc.dart';
import 'package:hey_dentist/Login/BLoC/LoginState.dart';
import 'package:hey_dentist/Login/Navigator/LoginNavigator.dart';
import 'package:hey_dentist/Register/BLoC/RegisterBloc.dart';
import 'package:hey_dentist/RegisterAppointment/BLoC/RegisterAppointmentBloc.dart';
import 'package:hey_dentist/RegisterAppointment/BLoC/RegisterAppointmentState.dart';
import 'package:hey_dentist/RegisterAppointment/Navigator/RegisterAppointmentNavigator.dart';
import 'package:hey_dentist/RegisterPatient/BLoC/RegisterPatientBloc.dart';
import 'package:hey_dentist/RegisterPatient/BLoC/RegisterPatientState.dart';
import 'package:hey_dentist/VisualizeAppointment/BLoC/VisualizeAppointmentBloc.dart';
import 'package:hey_dentist/VisualizeAppointment/BLoC/VisualizeAppointmentState.dart';

import 'Auth/auth.dart';
import 'HomePage/BLoC/HomePageBloc.dart';
import 'HomePage/BLoC/HomePageState.dart';
import 'HomePage/Navigator/HomePageNavigator.dart';
import 'Register/BLoC/RegisterState.dart';
import 'Register/Navigator/RegisterNavigator.dart';
import 'RegisterPatient/Navigator/RegisterPatientNavigator.dart';

class AppBlocProvider {
  List<BlocProvider> getAppBlocProvider() {
    List<BlocProvider> blocProviderList = [
      BlocProvider<LoginBloc>(
          create: (BuildContext context) => LoginBloc(
                LoginInitialState(),
                Auth(),
                LoginNavigator(),
                DentistRepository(api: DentistAPI()),
              )),
      BlocProvider<RegisterBloc>(
          create: (BuildContext context) => RegisterBloc(
              RegisterInitialState(),
              Auth(),
              RegisterNavigator(),
              DentistRepository(api: DentistAPI()))),
      BlocProvider<HomePageBloc>(
          create: (BuildContext context) =>
              HomePageBloc(HomePageInitialState(), HomePageNavigator())),
      BlocProvider<RegisterPatientBloc>(
          create: (BuildContext context) => RegisterPatientBloc(
              RegisterPatientInitialState(),
              DentistRepository(api: DentistAPI()),
              RegisterPatientNavigator())),
      BlocProvider<RegisterAppointmentBloc>(
          create: (BuildContext context) => RegisterAppointmentBloc(
              RegisterAppointmentInitialState(),
              RegisterAppointmentNavigator(),
              AppointmentRepository(api: AppointmentAPI()))),

      BlocProvider<VisualizeAppointmentBloc>(
          create: (BuildContext context) =>
              VisualizeAppointmentBloc(VisualizeAppointmentInitialState())),
    ];
    return blocProviderList;
  }
}
