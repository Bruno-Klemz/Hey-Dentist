import 'package:flutter/cupertino.dart';

abstract class RegisterEvent {}

class RegisterCreateDentistEvent extends RegisterEvent {
  final String email, password, userName, clinicName;
  final BuildContext context;

  RegisterCreateDentistEvent(
      {required this.email,
      required this.password,
      required this.context,
      required this.userName,
      required this.clinicName});
}

class RegisterCreateDentistFolderEvent extends RegisterEvent {
  final String userID, userName, clinicName;
  final BuildContext context;

  RegisterCreateDentistFolderEvent(
      {required this.userID, required this.clinicName, required this.userName, required this.context});
}

class RegisterSwitchToHomeEvent extends RegisterEvent {
  final BuildContext context;

  RegisterSwitchToHomeEvent({required this.context});
}
