import 'package:flutter/material.dart';

import '../BLoC/HomePageEvent.dart';

class HomePageNavigator {
  void navigate(HomePageEvent event, {Object? arguments}) {
    final castedEvent = event as HomePageSwitchToNextScreenEvent;
    String routeName = event.routeName;
    Navigator.of(castedEvent.context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }
}
