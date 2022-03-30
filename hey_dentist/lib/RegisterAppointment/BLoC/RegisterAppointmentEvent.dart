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

  RegisterAppointmentHourPickerEvent({required this.hour, required this.label});
}

class RegisterAppointmentRegisterEvent extends RegisterAppointmentEvent {
  final String dentistName, pacientName, date, initialHour, endHour;
  final String? procedure, tools, observations;
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
      this.procedure,
      this.tools,
      this.observations});
}
