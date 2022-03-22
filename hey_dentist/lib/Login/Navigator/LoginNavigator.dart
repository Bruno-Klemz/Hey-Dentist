import 'package:flutter/material.dart';

import '../BLoC/LoginEvent.dart';

class LoginNavigator{
  void navigate(LoginEvent event, {Object? arguments}) {
    switch (event.runtimeType) {
      case LoginSwitchToHomeEvent:
        final castedEvent = event as LoginSwitchToHomeEvent;
        const String routeName = 'LoginScreenToRegisterScreen';
        Navigator.of(castedEvent.context).pushNamed(
          routeName,
          arguments: arguments,
        );
    }
  }
}