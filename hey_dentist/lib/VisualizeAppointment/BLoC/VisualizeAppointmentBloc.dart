import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Data/Appointment/AppointmentModel.dart';
import '../../Data/Dentist/UserModel.dart';
import 'VisualizeAppointmentEvent.dart';
import 'VisualizeAppointmentState.dart';

class VisualizeAppointmentBloc
    extends Bloc<VisualizeAppointmentEvent, VisualizeAppointmentState> {
  VisualizeAppointmentBloc(initialState) : super(initialState) {
    on<VisualizeAppointmentSelectDateEvent>((event, emit) {
      String formattedDate = _formatDate(
          event.datetime.day, event.datetime.month, event.datetime.year);

      String namedMonth = _getNamedMonth(event.datetime.month);

      List<Appointment> appointmentList =
          _getAppointmentsByDate(formattedDate, event.user);

      emit(VisualizeAppointmentFetchedAppointmentState(
          appointmentList: appointmentList, day: event.datetime.day.toString(), month: namedMonth));
    });
  }

  String _formatDate(int day, int month, int year) {
    return '$day-$month-$year';
  }

  List<Appointment> _getAppointmentsByDate(String date, UserModel user) {
    List<Appointment> appointmentList = [];
    for (Appointment appointment in user.appointmentList) {
      if (appointment.date == date) {
        appointmentList.add(appointment);
      }
    }
    return appointmentList;
  }

  String _getNamedMonth(int month) {
    List<String> namedMonthList = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez'
    ];
    return namedMonthList[month - 1];
  }
}
