import 'package:flutter/material.dart';
import 'package:hey_dentist/RegisterPatient/BLoC/RegisterPatientEvent.dart';

class RegisterPatientNavigator {
  void navigate(RegisterPatientEvent event, {Object? arguments}) {
    switch (event.runtimeType) {
      case RegisterPatientSaveAndSwitchScreenEvent:
        final castedEvent = event as RegisterPatientSaveAndSwitchScreenEvent;
        Navigator.of(castedEvent.context).popAndPushNamed(
          event.routeName,
          arguments: arguments,
        );
        break;
    }
  }
}
