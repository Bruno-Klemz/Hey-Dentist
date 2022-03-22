import 'package:flutter/cupertino.dart';

abstract class RegisterEvent {}

class RegisterCreateDentistEvent extends RegisterEvent {
  final String email, password;
  final BuildContext context;

  RegisterCreateDentistEvent(
      {required this.email, required this.password, required this.context});
}

class RegisterSwitchToHomeEvent extends RegisterEvent {
  final BuildContext context;

  RegisterSwitchToHomeEvent({required this.context});
}
