import 'package:flutter/cupertino.dart';

import '../../Data/Dentist/UserModel.dart';
import '../../Data/Dentist/UserModel.dart';

abstract class HomePageEvent {}

class HomePageSwitchToNextScreenEvent extends HomePageEvent {
  final BuildContext context;
  final String routeName;
  final UserModel user;

  HomePageSwitchToNextScreenEvent(
      {required this.context, required this.routeName, required this.user});
}
