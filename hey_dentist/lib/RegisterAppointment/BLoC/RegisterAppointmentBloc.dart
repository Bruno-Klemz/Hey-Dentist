import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentModel.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentRepository.dart';
import 'package:hey_dentist/Data/Dentist/UserModel.dart';
import 'package:hey_dentist/RegisterAppointment/Navigator/RegisterAppointmentNavigator.dart';

import 'RegisterAppointmentEvent.dart';
import 'RegisterAppointmentState.dart';

class RegisterAppointmentBloc
    extends Bloc<RegisterAppointmentEvent, RegisterAppointmentState> {
  RegisterAppointmentBloc(RegisterAppointmentState initialState,
      RegisterAppointmentNavigator navigator, AppointmentRepository repo)
      : super(initialState) {
    on<RegisterAppointmentDropDownChangedEvent>((event, emit) => emit(
        RegisterAppointmentDropDownChangedState(
            dropDownMap: event.dropDownMap)));
    on<RegisterAppointmentDatePickerEvent>((event, emit) {
      String formattedDate =
          '${event.date.day}-${event.date.month}-${event.date.year}';

      emit(RegisterAppointmentDatePickerState(date: formattedDate));
    });
    on<RegisterAppointmentHourPickerEvent>((event, emit) {
      String formattedHour = '';

      if (event.hour?.minute != null) {
        int minute = event.hour?.minute as int;
        if (minute < 10) {
          formattedHour = '${event.hour?.hour}:0${event.hour?.minute}';
        } else {
          formattedHour = '${event.hour?.hour}:${event.hour?.minute}';
        }
      }

      if (event.label == 'Hora inicial') {
        emit(RegisterAppointmentInitialHourPickerState(
            hour: formattedHour, label: event.label));
      } else {
        emit(RegisterAppointmentEndHourPickerState(
            hour: formattedHour, label: event.label));
      }
    });
    on<RegisterAppointmentRegisterEvent>((event, emit) async {
      UserModel user = event.user;
      Appointment appointment = Appointment(
          pacientName: event.pacientName,
          dentistName: event.dentistName,
          date: event.date,
          initialHour: event.initialHour,
          endHour: event.endHour);
      user.appointmentList.add(appointment);
      await repo.createNewAppointment(userID: user.userID, model: appointment);

      navigator.navigate(event, arguments: user);
    });
  }
}
