import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Dentist/DentistRepository.dart';
import 'package:hey_dentist/Register/Navigator/RegisterNavigator.dart';

import '../../Auth/auth.dart';
import 'RegisterEvent.dart';
import 'RegisterState.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(initialState, Auth _auth, RegisterNavigator navigator,
      DentistRepository _repo)
      : super(initialState) {
    on<RegisterCreateDentistEvent>((event, emit) async {
      try {
        UserCredential userCredential =
            await _auth.registerWithEmail(event.email, event.password);
        BlocProvider.of<RegisterBloc>(event.context).add(
            RegisterCreateDentistFolderEvent(
                userID: userCredential.user?.uid as String,
                userName: event.userName,
                clinicName: event.clinicName,
                context: event.context));
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'email-already-in-use':
            emit(RegisterErrorState(errorMessage: "Email já está em uso!"));
            break;
          case 'invalid-email':
            emit(
                RegisterErrorState(errorMessage: "Formato de email inválido!"));
            break;
          case 'weak-password':
            emit(RegisterErrorState(errorMessage: "Senha fraca!"));
            break;
        }
      }
    });
    on<RegisterCreateDentistFolderEvent>((event, emit) async {
      int responseStatusCode = await _repo.createDentistFolder(
          userID: event.userID,
          userName: event.userName,
          clinicName: event.clinicName);
      if (responseStatusCode == 200) {
        navigator.navigate(RegisterSwitchToHomeEvent(context: event.context));
      }
    });
  }
}
