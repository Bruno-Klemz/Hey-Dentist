import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentModel.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentRepository.dart';
import 'package:hey_dentist/Data/Dentist/UserModel.dart';
import 'package:hey_dentist/Helpers/BusinessLogic/Duration.dart';
import 'package:hey_dentist/RegisterAppointment/Navigator/RegisterAppointmentNavigator.dart';

import 'RegisterAppointmentEvent.dart';
import 'RegisterAppointmentState.dart';

class RegisterAppointmentBloc
    extends Bloc<RegisterAppointmentEvent, RegisterAppointmentState> {
  DurationBusinessLogic durationBusinessLogic;
  Duration durationRef = Duration(hours: 0, minutes: 0);
  RegisterAppointmentBloc(
      RegisterAppointmentState initialState,
      RegisterAppointmentNavigator navigator,
      AppointmentRepository repo,
      this.durationBusinessLogic)
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
      if (event.hour != null &&
          (event.hour?.minute == 0 || event.hour?.minute == 30)) {
        String initialHour = '${DateTime.now().hour}:${DateTime.now().minute}';
        String endHour = '${event.hour?.hour}:${event.hour?.minute}';
        if (event.isSameDay == true &&
            (_getIsLaterThan(initialHour: initialHour, endHour: endHour))) {
          if (event.initialHour != null &&
              _getIsLaterThan(
                  initialHour: event.initialHour as String, endHour: endHour)) {
            BlocProvider.of<RegisterAppointmentBloc>(event.context).add(
                RegisterAppointmentEmitHourPickerEvent(
                    hour: event.hour as TimeOfDay, label: event.label));
          } else if (event.initialHour == null) {
            BlocProvider.of<RegisterAppointmentBloc>(event.context).add(
                RegisterAppointmentEmitHourPickerEvent(
                    hour: event.hour as TimeOfDay, label: event.label));
          } else {
            emit(RegisterAppointmentHourErrorState(
                errorMessage:
                    'Hora impossível, escolha um horário depois do atual',
                label: event.label));
          }
        } else if (event.isSameDay == false) {
          BlocProvider.of<RegisterAppointmentBloc>(event.context).add(
              RegisterAppointmentEmitHourPickerEvent(
                  hour: event.hour as TimeOfDay, label: event.label));
        } else {
          emit(RegisterAppointmentHourErrorState(
              errorMessage:
                  'Hora impossível, escolha um horário depois do atual',
              label: event.label));
        }
      } else {
        emit(RegisterAppointmentHourErrorState(
            errorMessage: 'Os valores de minuto devem ser 0 ou 30',
            label: event.label));
      }
    });
    on<RegisterAppointmentRegisterEvent>((event, emit) async {
      UserModel user = event.user;
      Appointment appointment = Appointment(
          pacientName: event.pacientName,
          dentistName: event.dentistName,
          date: event.date,
          initialHour: event.initialHour,
          endHour: event.endHour,
          procedure: event.procedure);
      user.appointmentList.add(appointment);
      await repo.createNewAppointment(userID: user.userID, model: appointment);

      navigator.navigate(event, arguments: user);
    });
    on<RegisterAppointmentHourErrorEvent>((event, emit) => emit(
        RegisterAppointmentHourErrorState(
            errorMessage: event.errorMessage, label: event.label)));

    on<RegisterAppointmentEmitHourPickerEvent>((event, emit) {
      final hourPickerEnum = _getHourPickerEnum(event.label, event.hour);
      if (hourPickerEnum == HourPickerEnum.initialHour) {
        emit(RegisterAppointmentInitialHourPickerState(
            label: event.label,
            hour: '${event.hour.hour}:${event.hour.minute}',
            timeOfDay: event.hour));
      } else {
        emit(RegisterAppointmentEndHourPickerState(
            label: event.label,
            hour: '${event.hour.hour}:${event.hour.minute}',
            timeOfDay: event.hour));
      }
    });
  }

  HourPickerEnum _getHourPickerEnum(String label, TimeOfDay hour) {
    if (label == 'Hora inicial') {
      return HourPickerEnum.initialHour;
    } else {
      return HourPickerEnum.endHour;
    }
  }

  bool _getIsLaterThan({required String initialHour, required String endHour}) {
    final duration =
        durationBusinessLogic.getAppointmentDuration(initialHour, endHour);
    if (duration > durationRef) {
      return true;
    } else {
      return false;
    }
  }
}

enum HourPickerEnum { initialHour, endHour }
