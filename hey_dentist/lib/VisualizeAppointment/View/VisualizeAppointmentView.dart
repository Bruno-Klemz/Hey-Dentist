import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentModel.dart';
import 'package:hey_dentist/Data/Dentist/UserModel.dart';
import 'package:hey_dentist/VisualizeAppointment/BLoC/VisualizeAppointmentBloc.dart';
import 'package:hey_dentist/VisualizeAppointment/BLoC/VisualizeAppointmentState.dart';

import '../../Components/CustomText.dart';
import '../BLoC/VisualizeAppointmentEvent.dart';

class VisualizeAppointment extends StatelessWidget {
  final customText = CustomText();
  final layoutConstrains = VisualizeAppointmentLayoutConstrains();
  final UserModel user;
  final BuildContext context;
  List<Appointment> appointmentList = [];
  List<String> hourList = HourList().getHourList();

  VisualizeAppointment({Key? key, required this.user, required this.context})
      : super(key: key) {
    BlocProvider.of<VisualizeAppointmentBloc>(context).add(
        VisualizeAppointmentSelectDateEvent(
            datetime: DateTime.now(), user: user));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: EdgeInsets.all(layoutConstrains.screenPadding),
          child:
              BlocBuilder<VisualizeAppointmentBloc, VisualizeAppointmentState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case VisualizeAppointmentFetchedAppointmentState:
                  final _castedState =
                      state as VisualizeAppointmentFetchedAppointmentState;

                  appointmentList = _castedState.appointmentList;

                  return ListView.builder(
                      itemCount: hourList.length,
                      itemBuilder: _buildListViewItem);
                default:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
              }
            },
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF6B5347),
      title: Row(
        children: [
          BlocBuilder<VisualizeAppointmentBloc, VisualizeAppointmentState>(
            builder: (BuildContext context, VisualizeAppointmentState state) {
              switch (state.runtimeType) {
                case VisualizeAppointmentFetchedAppointmentState:
                  final _castedState =
                      state as VisualizeAppointmentFetchedAppointmentState;
                  return customText.buildText(
                      label: '${_castedState.day} ${_castedState.month}',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500);
                default:
                  return customText.buildText(
                      label: '',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500);
              }
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: layoutConstrains.iconSize,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListViewItem(BuildContext context, int index) {
    Appointment appointment = appointmentList.firstWhere(
        (Appointment appointment) {
      return (getAppointmentDuration(
                  appointment.initialHour, hourList[index]) >=
              const Duration(hours: 0, minutes: 0) &&
          getAppointmentDuration(hourList[index], appointment.endHour) >=
              const Duration(hours: 0, minutes: 0));
    },
        orElse: () => Appointment(
            pacientName: '',
            dentistName: '',
            date: '',
            initialHour: '',
            endHour: '',
            procedure: ''));

    return Padding(
      padding: index != 0
          ? EdgeInsets.only(top: layoutConstrains.cardsPadding)
          : const EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customText.buildText(
              label: hourList[index],
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.hourLabelFontSize,
              fontWeight: FontWeight.w400),
          Container(
            width: layoutConstrains.cardsWidth,
            height: layoutConstrains.cardsHeight,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: layoutConstrains.cardsBorderWidth,
                    color: const Color(0xFFD1B66F)),
                borderRadius: BorderRadius.all(
                    Radius.circular(layoutConstrains.cardsBorderRadius))),
            child: Padding(
              padding:
                  EdgeInsets.only(left: layoutConstrains.labelsToCardPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText.buildText(
                      label: appointment.pacientName,
                      color: const Color(0xFF6B5347),
                      fontSize: layoutConstrains.cardFontSize,
                      fontWeight: FontWeight.bold),
                  customText.buildText(
                      label: appointment.dentistName,
                      color: const Color(0xFF6B5347),
                      fontSize: layoutConstrains.cardFontSize,
                      fontWeight: FontWeight.w400),
                  customText.buildText(
                      label: appointment.procedure,
                      color: const Color(0xFF6B5347),
                      fontSize: layoutConstrains.cardFontSize,
                      fontWeight: FontWeight.w400),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Duration getAppointmentDuration(String initialHour, String endHour) {
    int intInitialHour = int.parse(initialHour.split(":")[0]);
    int intInitialMinute = int.parse(initialHour.split(":")[1]);
    int intEndHour = int.parse(endHour.split(":")[0]);
    int intEndMinute = int.parse(endHour.split(":")[1]);

    Duration initialHourDuration =
        Duration(hours: intInitialHour, minutes: intInitialMinute);

    Duration endHourDuration =
        Duration(hours: intEndHour, minutes: intEndMinute);

    Duration result = endHourDuration - initialHourDuration;
    return result;
  }
}

class HourList {
  List<String> getHourList() {
    return [
      '8:00',
      '8:30',
      '9:00',
      '9:30',
      '10:00',
      '10:30',
      '11:00',
      '11:30',
      '12:00',
      '12:30',
      '13:00',
      '13:30',
      '14:00',
      '14:30',
      '15:00',
      '15:30',
      '16:00',
      '16:30',
      '17:00',
      '17:30',
      '18:00',
      '18:30',
      '19:00',
      '19:30',
      '20:00',
      '20:30',
      '21:00',
      '21:30',
      '22:00'
    ];
  }
}

class VisualizeAppointmentLayoutConstrains {
  double titleArrowToLabelPadding = 5.0,
      screenPadding = 15.0,
      iconSize = 24,
      cardsPadding = 34.0,
      labelsToCardPadding = 10.0,
      hourLabelFontSize = 18.0,
      cardFontSize = 14.0,
      cardsWidth = 290.0,
      cardsHeight = 75.0,
      cardsBorderWidth = 2.5,
      cardsBorderRadius = 10;
}
