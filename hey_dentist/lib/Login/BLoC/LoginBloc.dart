import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Auth/auth.dart';
import 'LoginEvent.dart';
import 'LoginState.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(initialState, Auth auth) : super(initialState) {
    on<LoginLoginEvent>((event, emit) async {
      try {
        await auth.signIn(email: event.email, password: event.password);
        BlocProvider.of<LoginBloc>(event.context)
            .add(LoginSwitchToHomeEvent(context: event.context));
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
  }
}
