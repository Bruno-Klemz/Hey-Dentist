import 'package:flutter/cupertino.dart';

import '../../Data/Pacient/PacientModel.dart';

abstract class RegisterPatientEvent {}

class RegisterPatientSaveAndSwitchScreenEvent extends RegisterPatientEvent {
  final BuildContext context;
  final Pacient model;
  final String routeName;

  RegisterPatientSaveAndSwitchScreenEvent(
      {required this.context, required this.model, required this.routeName});
}
