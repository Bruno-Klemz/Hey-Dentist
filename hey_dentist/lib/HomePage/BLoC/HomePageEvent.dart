import 'package:flutter/cupertino.dart';

abstract class HomePageEvent {}


class HomePageSwitchToNextScreenEvent extends HomePageEvent {
  final BuildContext context;
  final String routeName;

  HomePageSwitchToNextScreenEvent(
      {required this.context, required this.routeName});
}
