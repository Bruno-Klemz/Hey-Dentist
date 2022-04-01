import 'dart:convert';

import 'package:hey_dentist/Data/Appointment/AppointmentAPI.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentModel.dart';

class AppointmentRepository {
  final AppointmentAPI api;

  AppointmentRepository({required this.api});

  Future<void> createNewAppointment(
      {required String? userID, required Appointment model}) async {
    String json = jsonEncode(model);
    await api.createAppointment(
        userID: userID,
        body: json,
        pacientName: model.pacientName,
        date: model.date);
  }
}
