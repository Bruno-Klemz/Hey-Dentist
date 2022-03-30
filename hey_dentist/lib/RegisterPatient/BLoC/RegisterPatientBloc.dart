import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Dentist/UserRepository.dart';
import 'package:hey_dentist/RegisterPatient/Navigator/RegisterPatientNavigator.dart';

import 'RegisterPatientEvent.dart';
import 'RegisterPatientState.dart';

class RegisterPatientBloc
    extends Bloc<RegisterPatientEvent, RegisterPatientState> {
  RegisterPatientBloc(
      initialState, DentistRepository _repo, RegisterPatientNavigator navigator)
      : super(initialState) {
    final currentUser = FirebaseAuth.instance.currentUser;
    on<RegisterPatientSaveAndSwitchScreenEvent>((event, emit) async {
      if (event.model.name == '' ||
          event.model.id == '' ||
          event.model.lastName == '') {
        emit(RegisterPatientErrorState(
            errorMessage: 'Campos obrigatórios não preenchidos!'));
      } else {
        int response =
            await _repo.createNewPacient(currentUser?.uid, event.model);
        if (response == 200) {
          navigator.navigate(event);
        } else {
          emit(RegisterPatientErrorState(
              errorMessage: 'Algo deu errado no sistema, tente novamente!'));
        }
      }
    });
  }
}
