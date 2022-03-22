abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final String errorMessage;

  RegisterErrorState({required this.errorMessage});
}
