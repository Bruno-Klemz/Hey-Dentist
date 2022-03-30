abstract class RegisterAppointmentState {}

class RegisterAppointmentInitialState extends RegisterAppointmentState {
  
}

class RegisterAppointmentDropDownChangedState extends RegisterAppointmentState {
  final Map<String, String> dropDownMap;

  RegisterAppointmentDropDownChangedState({required this.dropDownMap});
}

class RegisterAppointmentDatePickerState extends RegisterAppointmentState {
  final String date;

  RegisterAppointmentDatePickerState({required this.date});
}

class RegisterAppointmentInitialHourPickerState extends RegisterAppointmentState {
  final String hour, label;

  RegisterAppointmentInitialHourPickerState({required this.hour, required this.label});
}

class RegisterAppointmentEndHourPickerState extends RegisterAppointmentState {
  final String hour, label;

  RegisterAppointmentEndHourPickerState({required this.hour, required this.label});
}
