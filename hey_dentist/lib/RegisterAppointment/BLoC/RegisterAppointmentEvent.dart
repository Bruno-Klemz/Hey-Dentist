import 'package:flutter/material.dart';

import '../../Data/Dentist/UserModel.dart';

abstract class RegisterAppointmentEvent {}

class RegisterAppointmentDropDownChangedEvent extends RegisterAppointmentEvent {
  final Map<String, String> dropDownMap;

  RegisterAppointmentDropDownChangedEvent({required this.dropDownMap});
}

class RegisterAppointmentDatePickerEvent extends RegisterAppointmentEvent {
  final DateTime date;

  RegisterAppointmentDatePickerEvent({required this.date});
}

class RegisterAppointmentHourPickerEvent extends RegisterAppointmentEvent {
  final TimeOfDay? hour;
  final String label;
  final String? initialHour;
  final bool isSameDay;
  final BuildContext context;

  RegisterAppointmentHourPickerEvent(
      {required this.hour,
      required this.label,
      required this.isSameDay,
      required this.context,
      this.initialHour});
}

class RegisterAppointmentEmitHourPickerEvent extends RegisterAppointmentEvent {
  final String label;
  final TimeOfDay hour;

  RegisterAppointmentEmitHourPickerEvent(
      {required this.label, required this.hour});
}

class RegisterAppointmentRegisterEvent extends RegisterAppointmentEvent {
  final String dentistName, pacientName, date, initialHour, endHour;
  final String procedure;
  final UserModel user;
  final BuildContext context;

  RegisterAppointmentRegisterEvent(
      {required this.dentistName,
      required this.pacientName,
      required this.date,
      required this.initialHour,
      required this.endHour,
      required this.user,
      required this.context,
      required this.procedure});
}

class RegisterAppointmentHourErrorEvent extends RegisterAppointmentEvent {
  final String errorMessage, label;

  RegisterAppointmentHourErrorEvent(
      {required this.errorMessage, required this.label});
}
