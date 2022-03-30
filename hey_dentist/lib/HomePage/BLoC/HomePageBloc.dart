import 'package:flutter_bloc/flutter_bloc.dart';
import '../Navigator/HomePageNavigator.dart';
import 'HomePageEvent.dart';
import 'HomePageState.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(initialState, HomePageNavigator navigator)
      : super(initialState) {
    on<HomePageSwitchToNextScreenEvent>((event, emit) {
      navigator.navigate(event, arguments: event.user);
    });
  }
}
