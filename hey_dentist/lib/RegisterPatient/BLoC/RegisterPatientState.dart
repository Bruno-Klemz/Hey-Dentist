abstract class RegisterPatientState {}

class RegisterPatientInitialState extends RegisterPatientState {}

class RegisterPatientErrorState extends RegisterPatientState {
  final String errorMessage;

  RegisterPatientErrorState({required this.errorMessage});
}
