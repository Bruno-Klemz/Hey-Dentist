import 'dart:convert';
import 'package:hey_dentist/Data/Appointment/AppointmentModel.dart';
import 'package:hey_dentist/Data/Clinic/ClinicModel.dart';

import '../Pacient/PacientModel.dart';
import 'UserModel.dart';
import 'UserAPI.dart';
import 'package:http/http.dart';

class DentistRepository {
  final DentistAPI api;
  DentistRepository({required this.api});

  Future<Map<String, dynamic>> createDentistFolder(
      {required String? userID,
      required String userName,
      required String clinicName}) async {
    Map<String, dynamic> json = {
      'Clinic': {
        'dentistList': {
          userName: {'UserID': userID}
        },
        'Name': clinicName
      }
    };
    String jsonEncoded = jsonEncode(json);
    await api.createDentistFolder(userID: userID, body: jsonEncoded);
    return json;
  }

  Future<int> createNewPacient(String? userID, Pacient model) async {
    String body = jsonEncode({'${model.name} ${model.lastName}': model});
    int responseStatusCode =
        (await api.createNewPacient(userID: userID, body: body)).statusCode;
    return responseStatusCode;
  }

  Future<UserModel> getDentistByID(String? userID) async {
    Response response = await api.getDentistByID(userID);
    List<Appointment> appointmentList = [];
    List<Pacient> pacientList = [];
    List<Dentist> dentistList = [];
    late Clinic clinic;
    late String clinicName;

    final jsonDecoded = jsonDecode(response.body) as Map<String, dynamic>;
    for (final key in jsonDecoded.keys) {
      switch (key) {
        case 'Appointment':
          final appointmentJson = jsonDecoded[key] as Map<String, dynamic>;
          for (final appointmentKey in appointmentJson.keys) {
            final pacientJson = appointmentJson[appointmentKey] as Map<String, dynamic>;
            for(final pacientKey in pacientJson.keys){
              final appointment =
                Appointment.fromJson(pacientJson[pacientKey]);
            appointmentList.add(appointment);
            }
            
          }
          break;

        case 'Pacient':
          final pacientJson = jsonDecoded[key] as Map<String, dynamic>;
          for (final pacientKey in pacientJson.keys) {
            final pacient = Pacient.fromJson(pacientJson[pacientKey]);
            pacientList.add(pacient);
          }
          break;
        default:
          final clinicJson = jsonDecoded[key] as Map<String, dynamic>;
          for (final clinicKey in clinicJson.keys) {
            final dentistJson = clinicJson[clinicKey];
            if (clinicKey == 'DentistList') {
              for (final dentistKey in dentistJson.keys) {
                final dentist = Dentist.fromJson(dentistJson[dentistKey]);
                dentistList.add(dentist);
              }
            } else {
              clinicName = clinicJson[clinicKey];
            }
          }
          clinic = Clinic(name: clinicName, dentistList: dentistList);
          break;
      }
    }
    final dentist = UserModel(
        clinic: clinic,
        pacientList: pacientList,
        appointmentList: appointmentList, userID: userID);
    return dentist;
  }
}
