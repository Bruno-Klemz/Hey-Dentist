import 'package:flutter/material.dart';

import '../BLoC/LoginEvent.dart';

class LoginNavigator {
  void navigate(LoginEvent event, {Object? arguments}) {
    switch (event.runtimeType) {
      case LoginSwitchToHomeEvent:
        final castedEvent = event as LoginSwitchToHomeEvent;
        const String routeName = 'LoginScreenToHomeScreen';
        Navigator.of(castedEvent.context).pushNamed(
          routeName,
          arguments: arguments,
        );
        break;
      case LoginSwitchToRegisterEvent:
        final castedEvent = event as LoginSwitchToRegisterEvent;
        const String routeName = 'LoginScreenToRegisterScreen';
        Navigator.of(castedEvent.context).pushNamed(
          routeName,
          arguments: arguments,
        );
        break;
    }
  }
}
