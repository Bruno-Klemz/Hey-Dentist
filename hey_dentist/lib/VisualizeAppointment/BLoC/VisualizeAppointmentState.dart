import '../../Data/Appointment/AppointmentModel.dart';

abstract class VisualizeAppointmentState {}

class VisualizeAppointmentInitialState extends VisualizeAppointmentState {
}

class VisualizeAppointmentFetchedAppointmentState
    extends VisualizeAppointmentState {
  final List<Appointment> appointmentList;
  final String day, month;

  VisualizeAppointmentFetchedAppointmentState({required this.appointmentList, required this.day, required this.month});
}
