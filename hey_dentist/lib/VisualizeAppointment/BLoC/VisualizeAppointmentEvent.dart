import 'package:hey_dentist/Data/Dentist/UserModel.dart';

abstract class VisualizeAppointmentEvent {}

class VisualizeAppointmentSelectDateEvent extends VisualizeAppointmentEvent {
  final DateTime datetime;
  final UserModel user;

  VisualizeAppointmentSelectDateEvent({required this.datetime, required this.user});
}
