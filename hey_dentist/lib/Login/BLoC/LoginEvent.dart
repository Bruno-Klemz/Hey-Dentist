import 'package:flutter/cupertino.dart';

abstract class LoginEvent {}

class LoginLoginEvent extends LoginEvent {
  final String email, password;
  final BuildContext context;

  LoginLoginEvent(
      {required this.email, required this.password, required this.context});
}

class LoginRegisterEvent extends LoginEvent {}

class LoginSwitchToHomeEvent extends LoginEvent {
  final BuildContext context;

  LoginSwitchToHomeEvent({required this.context});
}
