import '../Appointment/AppointmentModel.dart';
import '../Clinic/ClinicModel.dart';
import '../Pacient/PacientModel.dart';

class UserModel {
  final Clinic clinic;
  final List<Appointment> appointmentList;
  final List<Pacient> pacientList;
  final String? userID;

  UserModel(
      {required this.appointmentList,
      required this.pacientList,
      required this.clinic, required this.userID});
}
