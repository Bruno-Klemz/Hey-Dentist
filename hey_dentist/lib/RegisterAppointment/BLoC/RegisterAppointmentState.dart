import 'package:flutter/material.dart';

abstract class RegisterAppointmentState {}

class RegisterAppointmentInitialState extends RegisterAppointmentState {}

class RegisterAppointmentDropDownChangedState extends RegisterAppointmentState {
  final Map<String, String> dropDownMap;

  RegisterAppointmentDropDownChangedState({required this.dropDownMap});
}

class RegisterAppointmentDatePickerState extends RegisterAppointmentState {
  final String date;

  RegisterAppointmentDatePickerState({required this.date});
}

class RegisterAppointmentInitialHourPickerState
    extends RegisterAppointmentState {
  final String hour, label;
  TimeOfDay timeOfDay;
  RegisterAppointmentInitialHourPickerState(
      {required this.hour, required this.label, required this.timeOfDay});
}

class RegisterAppointmentEndHourPickerState extends RegisterAppointmentState {
  final String hour, label;
  TimeOfDay timeOfDay;

  RegisterAppointmentEndHourPickerState(
      {required this.hour, required this.label, required this.timeOfDay});
}

class RegisterAppointmentHourErrorState extends RegisterAppointmentState {
  final String errorMessage, label;

  RegisterAppointmentHourErrorState(
      {required this.errorMessage, required this.label});
}
