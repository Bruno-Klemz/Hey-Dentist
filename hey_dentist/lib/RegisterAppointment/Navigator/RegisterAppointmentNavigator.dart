import 'package:flutter/material.dart';
import 'package:hey_dentist/RegisterAppointment/BLoC/RegisterAppointmentEvent.dart';

class RegisterAppointmentNavigator {
  void navigate(RegisterAppointmentEvent event, {Object? arguments}) {
    switch (event.runtimeType) {
      case RegisterAppointmentRegisterEvent:
        final castedEvent = event as RegisterAppointmentRegisterEvent;
        const routeName = 'RegisterAppointmentToHome';
        Navigator.of(castedEvent.context).popAndPushNamed(
          routeName,
          arguments: arguments,
        );
        break;
    }
  }
}
