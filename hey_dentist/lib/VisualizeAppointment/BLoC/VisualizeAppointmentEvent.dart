import 'package:hey_dentist/Data/Dentist/UserModel.dart';

abstract class VisualizeAppointmentEvent {}

class VisualizeAppointmentFetchAppointmentEvent
    extends VisualizeAppointmentEvent {
  final DateTime datetime;
  final UserModel user;

  VisualizeAppointmentFetchAppointmentEvent(
      {required this.datetime, required this.user});
}

class VisualizeAppointmentManageCalendarEvent
    extends VisualizeAppointmentEvent {
  final bool isOpen;

  VisualizeAppointmentManageCalendarEvent({required this.isOpen});
}
