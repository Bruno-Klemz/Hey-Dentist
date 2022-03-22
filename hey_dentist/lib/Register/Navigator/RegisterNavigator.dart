import 'package:flutter/material.dart';

import '../BLoC/RegisterEvent.dart';

class RegisterNavigator{
  void navigate(RegisterEvent event, {Object? arguments}) {
    switch (event.runtimeType) {
      case RegisterSwitchToHomeEvent:
        final castedEvent = event as RegisterSwitchToHomeEvent;
        const String routeName = 'RegisterScreenToHomeScreen';
        Navigator.of(castedEvent.context).pushNamed(
          routeName,
          arguments: arguments,
        );
    }
  }
}