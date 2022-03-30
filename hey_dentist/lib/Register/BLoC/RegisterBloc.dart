import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Clinic/ClinicModel.dart';
import 'package:hey_dentist/Data/Dentist/UserRepository.dart';
import 'package:hey_dentist/Register/Navigator/RegisterNavigator.dart';

import '../../Auth/auth.dart';
import '../../Data/Dentist/UserModel.dart';
import 'RegisterEvent.dart';
import 'RegisterState.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final currentUser = FirebaseAuth.instance.currentUser;
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
      Map<String, dynamic> json = await _repo.createDentistFolder(
          userID: event.userID,
          userName: event.userName,
          clinicName: event.clinicName);
      UserModel dentist = UserModel(
          appointmentList: [],
          pacientList: [],
          clinic: Clinic.fromJson(json),
          userID: currentUser?.uid);
      navigator.navigate(RegisterSwitchToHomeEvent(context: event.context),
          arguments: dentist);
    });
  }
}
