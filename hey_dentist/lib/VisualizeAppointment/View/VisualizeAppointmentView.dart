import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Appointment/AppointmentModel.dart';
import 'package:hey_dentist/Data/Dentist/UserModel.dart';
import 'package:hey_dentist/Helpers/BusinessLogic/DateTime.dart';
import 'package:hey_dentist/VisualizeAppointment/BLoC/VisualizeAppointmentBloc.dart';
import 'package:hey_dentist/VisualizeAppointment/BLoC/VisualizeAppointmentState.dart';
import '../../Helpers/BusinessLogic/Duration.dart';
import '../../Helpers/Components/CustomText.dart';
import '../BLoC/VisualizeAppointmentEvent.dart';
import 'package:table_calendar/table_calendar.dart';

class VisualizeAppointment extends StatefulWidget {
  final UserModel user;
  final BuildContext context;
  final DateTimeBusinessLogic dateTimeBusinessLogic;

  VisualizeAppointment(
      {Key? key,
      required this.user,
      required this.context,
      required this.dateTimeBusinessLogic})
      : super(key: key) {
    BlocProvider.of<VisualizeAppointmentBloc>(context).add(
        VisualizeAppointmentFetchAppointmentEvent(
            datetime: DateTime.now(), user: user));
  }

  @override
  State<VisualizeAppointment> createState() => _VisualizeAppointmentState();
}

class _VisualizeAppointmentState extends State<VisualizeAppointment> {
  final customText = CustomText();

  final layoutConstrains = VisualizeAppointmentLayoutConstrains();

  final durationBusinessLogic = DurationBusinessLogic();

  List<Appointment> appointmentList = [];

  List<String> hourList = HourList().getHourList();
  DateTime focusedDay = DateTime.now();
  DateTime currentDay = DateTime.now();

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
                case VisualizeAppointmentCalendarOpenedState:
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: layoutConstrains.calendarHeight,
                          width: layoutConstrains.calendarWidth,
                          child: TableCalendar(
                            currentDay: currentDay,
                            headerVisible: false,
                            firstDay: DateTime(DateTime.now().year, 1),
                            lastDay: DateTime(DateTime.now().year, 12),
                            focusedDay: focusedDay,
                            onDaySelected:
                                (DateTime selectedDay, DateTime focusedDay) {
                              BlocProvider.of<VisualizeAppointmentBloc>(context)
                                  .add(
                                      VisualizeAppointmentFetchAppointmentEvent(
                                          datetime: selectedDay,
                                          user: widget.user));
                              setState(() {
                                this.focusedDay = focusedDay;
                                currentDay = selectedDay;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount: hourList.length,
                              itemBuilder: _buildListViewItem),
                        ),
                      ],
                    ),
                  );
                case VisualizeAppointmentFetchedAppointmentState:
                  final _castedState =
                      state as VisualizeAppointmentFetchedAppointmentState;

                  appointmentList = _castedState.appointmentList;
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: hourList.length,
                        itemBuilder: _buildListViewItem),
                  );
                case VisualizeAppointmentCalendarClosedState:
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: hourList.length,
                        itemBuilder: _buildListViewItem),
                  );
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
                      label:
                          '${currentDay.day} ${widget.dateTimeBusinessLogic.getNamedMonth(focusedDay.month)}',
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500);
              }
            },
          ),
          BlocBuilder<VisualizeAppointmentBloc, VisualizeAppointmentState>(
            builder: (_, state) {
              return mapStateToAppBarTitle(state);
            },
          )
        ],
      ),
    );
  }

  IconButton mapStateToAppBarTitle(VisualizeAppointmentState state) {
    switch (state.runtimeType) {
      case VisualizeAppointmentCalendarOpenedState:
        final _castedState = state as VisualizeAppointmentCalendarOpenedState;
        return IconButton(
          onPressed: () {
            BlocProvider.of<VisualizeAppointmentBloc>(widget.context).add(
                VisualizeAppointmentManageCalendarEvent(
                    isOpen: _castedState.isOpen));
          },
          icon: Icon(
            _castedState.isOpen
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down,
            size: layoutConstrains.iconSize,
          ),
        );
      default:
        return IconButton(
          onPressed: () {
            BlocProvider.of<VisualizeAppointmentBloc>(widget.context)
                .add(VisualizeAppointmentManageCalendarEvent(isOpen: false));
          },
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: layoutConstrains.iconSize,
          ),
        );
    }
  }

  Widget _buildListViewItem(BuildContext context, int index) {
    Appointment appointment = appointmentList.firstWhere(
        (Appointment appointment) {
      return (durationBusinessLogic.getAppointmentDuration(
                  appointment.initialHour, hourList[index]) >=
              const Duration(hours: 0, minutes: 0) &&
          durationBusinessLogic.getAppointmentDuration(
                  hourList[index], appointment.endHour) >
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
                crossAxisAlignment: CrossAxisAlignment.center,
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
      cardsBorderRadius = 10,
      calendarHeight = 280,
      calendarWidth = 415;
}
