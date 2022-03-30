import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Dentist/UserRepository.dart';
import 'package:hey_dentist/Login/Navigator/LoginNavigator.dart';

import '../../Auth/auth.dart';
import '../../Data/Dentist/UserModel.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final currentUser = FirebaseAuth.instance.currentUser;
  LoginBloc(
      initialState, Auth auth, LoginNavigator navigator, DentistRepository repo)
      : super(initialState) {
    on<LoginLoginEvent>((event, emit) async {
      try {
        await auth.signIn(email: event.email, password: event.password);
        UserModel user =  await repo.getDentistByID(currentUser?.uid);
        navigator.navigate(LoginSwitchToHomeEvent(context: event.context), arguments: user);

      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "user-not-found":
            emit(LoginErrorState(errorMessage: "Usuário não encontrado!"));
            break;
          case 'wrong-password':
            emit(LoginErrorState(errorMessage: "Senha incorreta!"));
            break;
          default:
            emit(LoginErrorState(
                errorMessage: "Algo deu errado, tente novamente!"));
            break;
        }
      }
    });
    on<LoginSwitchToRegisterEvent>((event, emit) => navigator.navigate(event));
  }
}
