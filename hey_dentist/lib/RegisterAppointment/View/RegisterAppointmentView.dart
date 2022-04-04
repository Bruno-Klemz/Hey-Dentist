import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/RegisterAppointment/BLoC/RegisterAppointmentBloc.dart';
import 'package:hey_dentist/RegisterAppointment/BLoC/RegisterAppointmentEvent.dart';
import 'package:hey_dentist/RegisterAppointment/BLoC/RegisterAppointmentState.dart';

import '../../Data/Clinic/ClinicModel.dart';
import '../../Data/Dentist/UserModel.dart';
import '../../Data/Pacient/PacientModel.dart';
import '../../Helpers/BusinessLogic/Duration.dart';
import '../../Helpers/Components/CustomText.dart';

class RegisterAppointment extends StatelessWidget {
  RegisterAppointment({Key? key, required this.user}) : super(key: key) {
    patientList = _fetchPacientList();
    dentistList = _fetchDentistNameList();
    actualDate = _fetchDateTime();
    dropDownValuesMap = {
      'Doctor': dentistList.first,
      'Patient': patientList.first
    };
    date = 'Escolha a data';
    initialHour = 'Escolha a hora de início';
    endHour = 'Escolha a hora de término';
  }
  bool isSameDay = true;
  final UserModel user;
  final customText = CustomText();
  final layoutConstrains = RegisterAppointmentLayoutConstrains();
  final durationBusinessLogic = DurationBusinessLogic();
  Map<String, String> dropDownValuesMap = {};
  List<String> dentistList = [];
  List<String> patientList = [];
  late String date, initialHour, endHour;
  final procedureController = TextEditingController();
  late DateTime actualDate;

  List<String> _fetchDentistNameList() {
    List<String> dentistNameList = [];
    for (Dentist dentist in user.clinic.dentistList) {
      dentistNameList.add(dentist.name);
    }
    return dentistNameList;
  }

  List<String> _fetchPacientList() {
    List<Pacient> patientModelList = user.pacientList;
    List<String> patientList = [];
    for (Pacient pacient in patientModelList) {
      patientList.add('${pacient.name} ${pacient.lastName}');
    }
    return patientList;
  }

  DateTime _fetchDateTime() {
    int actualYear = DateTime.now().year;
    int actualMonth = DateTime.now().month;
    int actualDay = DateTime.now().day;
    final actualDate = DateTime(actualYear, actualMonth, actualDay);
    return actualDate;
  }

  @override
  Widget build(BuildContext context) {
    layoutConstrains.horizontalScreenPadding =
        MediaQuery.of(context).size.width * 0.05;

    layoutConstrains.verticalScreenPadding =
        MediaQuery.of(context).size.height * 0.025;
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: layoutConstrains.horizontalScreenPadding,
              vertical: layoutConstrains.verticalScreenPadding),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    _buildDropDown(
                        context: context,
                        label: 'Doutor Responsável',
                        valuesList: dentistList,
                        dropDownValue: dropDownValuesMap['Doctor'] as String,
                        dropDownKey: 'Doctor'),
                    Padding(
                      padding:
                          EdgeInsets.only(top: layoutConstrains.widgetsPadding),
                      child: _buildDropDown(
                          context: context,
                          label: 'Paciente',
                          valuesList: patientList,
                          dropDownValue: dropDownValuesMap['Patient'] as String,
                          dropDownKey: 'Patient'),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: layoutConstrains.widgetsPadding),
                        child: _buildDatePicker(context)),
                    Padding(
                      padding:
                          EdgeInsets.only(top: layoutConstrains.widgetsPadding),
                      child: BlocBuilder<RegisterAppointmentBloc,
                          RegisterAppointmentState>(
                        builder: (BuildContext context,
                            RegisterAppointmentState state) {
                          return _buildHourPicker(
                              context, 'Hora inicial', state);
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: layoutConstrains.widgetsPadding),
                      child: BlocBuilder<RegisterAppointmentBloc,
                          RegisterAppointmentState>(
                        builder: (BuildContext context,
                            RegisterAppointmentState state) {
                          return _mapStateToHourErrorLabel(
                              state, 'Hora inicial');
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: layoutConstrains.widgetsPadding),
                      child: BlocBuilder<RegisterAppointmentBloc,
                          RegisterAppointmentState>(
                        builder: (BuildContext context,
                            RegisterAppointmentState state) {
                          return _buildHourPicker(context, 'Hora final', state);
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: layoutConstrains.widgetsPadding),
                      child: BlocBuilder<RegisterAppointmentBloc,
                          RegisterAppointmentState>(
                        builder: (BuildContext context,
                            RegisterAppointmentState state) {
                          return _mapStateToHourErrorLabel(state, 'Hora final');
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: layoutConstrains.widgetsPadding),
                      child: _buildTextInput(),
                    ),
                  ],
                ),
                BlocBuilder<RegisterAppointmentBloc, RegisterAppointmentState>(
                  builder:
                      (BuildContext context, RegisterAppointmentState state) {
                    return _mapStateToMainButton(
                        context: context, state: state);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: customText.buildText(
          label: 'Nova consulta',
          color: Colors.white,
          fontSize: layoutConstrains.titleFontSize,
          fontWeight: FontWeight.w500),
      backgroundColor: const Color(0xFFD1B66F),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildDropDown(
      {required String dropDownValue,
      required List<String> valuesList,
      required String label,
      required BuildContext context,
      required String dropDownKey}) {
    return SizedBox(
      width: layoutConstrains.widgetWidth,
      height: layoutConstrains.widgetHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText.buildText(
              label: label,
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.labelFontSize,
              fontWeight: FontWeight.w400),
          Padding(
            padding:
                EdgeInsets.only(top: layoutConstrains.widgetsToLabelPadding),
            child:
                BlocBuilder<RegisterAppointmentBloc, RegisterAppointmentState>(
              builder: (BuildContext context, RegisterAppointmentState state) {
                return _mapStateToDropDown(
                    state: state,
                    context: context,
                    valuesList: valuesList,
                    dropDownValue: dropDownValue,
                    dropDownKey: dropDownKey);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _mapStateToDropDown(
      {required RegisterAppointmentState state,
      required BuildContext context,
      required List<String> valuesList,
      required String dropDownValue,
      required String dropDownKey}) {
    switch (state.runtimeType) {
      case RegisterAppointmentDropDownChangedState:
        final _castedState = state as RegisterAppointmentDropDownChangedState;
        return _buildDropDownButton(
            dropDownValue: _castedState.dropDownMap[dropDownKey] as String,
            valuesList: valuesList,
            context: context,
            dropDownKey: dropDownKey);
      default:
        return _buildDropDownButton(
            dropDownValue: valuesList.first,
            valuesList: valuesList,
            context: context,
            dropDownKey: dropDownKey);
    }
  }

  Widget _buildDropDownButton(
      {required valuesList,
      required BuildContext context,
      required String dropDownValue,
      required String dropDownKey}) {
    return SizedBox(
      height: layoutConstrains.dropDownHeight,
      child: DropdownButton(
        key: Key(dropDownKey),
        value: dropDownValue,
        underline: Container(
          decoration: const ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 0.5,
                  style: BorderStyle.solid,
                  color: Color(0xFF6B5347)),
            ),
          ),
        ),
        icon: Icon(
          Icons.arrow_drop_down,
          size: layoutConstrains.iconSize,
          color: const Color(0xFF6B5347),
        ),
        isExpanded: true,
        style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto',
            fontSize: layoutConstrains.widgetsFontSize,
            fontWeight: FontWeight.w300),
        items: valuesList
            .map<DropdownMenuItem<String>>((String dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: customText.buildText(
                label: dropDownStringItem,
                color: const Color(0xFF6B5347),
                fontSize: layoutConstrains.valuesFontSize,
                fontWeight: FontWeight.w400),
          );
        }).toList(),
        onChanged: (String? newDropDownValue) {
          if (newDropDownValue != null) {
            dropDownValuesMap[dropDownKey] = newDropDownValue;
            BlocProvider.of<RegisterAppointmentBloc>(context).add(
                RegisterAppointmentDropDownChangedEvent(
                    dropDownMap: dropDownValuesMap));
          }
        },
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return SizedBox(
      width: layoutConstrains.widgetWidth,
      height: layoutConstrains.widgetHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText.buildText(
              label: 'Data',
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.labelFontSize,
              fontWeight: FontWeight.w400),
          Padding(
            padding:
                EdgeInsets.only(top: layoutConstrains.widgetsToLabelPadding),
            child: GestureDetector(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 20,
                  decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(width: 1.25, color: Color(0xFF6B5347))),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlocBuilder<RegisterAppointmentBloc,
                          RegisterAppointmentState>(
                        builder: (_, RegisterAppointmentState state) {
                          return _mapStateToDatePickerValue(state);
                        },
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        size: layoutConstrains.iconSize,
                        color: const Color(0xFF6B5347),
                      )
                    ],
                  )),
              onTap: () {
                getDatePicker(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void getDatePicker(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: actualDate,
      firstDate: DateTime(actualDate.year - 5, 1),
      lastDate: DateTime(actualDate.year + 5, 12),
      helpText: 'Selecione uma data',
    );

    if (newDate != null) {
      isSameDay =
          (durationBusinessLogic.getDateTimeDifference(actualDate, newDate)) ==
              0;
      actualDate = newDate;
      BlocProvider.of<RegisterAppointmentBloc>(context)
          .add(RegisterAppointmentDatePickerEvent(date: newDate));
    } else {
      BlocProvider.of<RegisterAppointmentBloc>(context)
          .add(RegisterAppointmentDatePickerEvent(date: actualDate));
    }
  }

  Widget _mapStateToDatePickerValue(RegisterAppointmentState state) {
    switch (state.runtimeType) {
      case RegisterAppointmentDatePickerState:
        final _castedState = state as RegisterAppointmentDatePickerState;
        date = _castedState.date;
        return customText.buildText(
            label: _castedState.date,
            color: const Color(0xFF6B5347),
            fontSize: layoutConstrains.valuesFontSize,
            fontWeight: FontWeight.w400);
      default:
        return customText.buildText(
            label: date,
            color: const Color(0xFF6B5347),
            fontSize: layoutConstrains.widgetsFontSize,
            fontWeight: FontWeight.w400);
    }
  }

  Widget _mapStateToHourErrorLabel(
      RegisterAppointmentState state, String label) {
    switch (state.runtimeType) {
      case RegisterAppointmentHourErrorState:
        final _castedState = state as RegisterAppointmentHourErrorState;
        if (_castedState.label == label) {
          return customText.buildText(
              label: _castedState.errorMessage,
              color: Colors.red,
              fontSize: layoutConstrains.valuesFontSize,
              fontWeight: FontWeight.w400);
        } else {
          return Container();
        }

      default:
        return Container();
    }
  }

  Widget _buildHourPicker(
      BuildContext context, String label, RegisterAppointmentState state) {
    Color color = _mapStateToColor(state: state, label: label);

    return SizedBox(
      width: layoutConstrains.widgetWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customText.buildText(
              label: label,
              color: color,
              fontSize: layoutConstrains.labelFontSize,
              fontWeight: FontWeight.w400),
          Padding(
              padding:
                  EdgeInsets.only(top: layoutConstrains.widgetsToLabelPadding),
              child: Column(
                children: [
                  GestureDetector(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 1.25, color: color)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<RegisterAppointmentBloc,
                                RegisterAppointmentState>(
                              builder: (_, RegisterAppointmentState state) {
                                return _mapStateToHourPickerLabel(state, label);
                              },
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: layoutConstrains.iconSize,
                              color: color,
                            )
                          ],
                        )),
                    onTap: () {
                      if ((label == 'Hora final' &&
                              (state.runtimeType ==
                                  RegisterAppointmentInitialHourPickerState || state.runtimeType ==
                                  RegisterAppointmentEndHourPickerState || state.runtimeType ==
                                  RegisterAppointmentHourErrorState))  ||
                          label == 'Hora inicial') {
                        getHour(context, label, state);
                      }
                    },
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Text _mapStateToHourPickerLabel(
      RegisterAppointmentState state, String label) {
    switch (state.runtimeType) {
      case RegisterAppointmentInitialHourPickerState:
        final _castedState = state as RegisterAppointmentInitialHourPickerState;
        initialHour = _castedState.hour;
        if (label == _castedState.label) {
          return customText.buildText(
              label: initialHour,
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.valuesFontSize,
              fontWeight: FontWeight.w400);
        } else {
          return customText.buildText(
              label: endHour,
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.valuesFontSize,
              fontWeight: FontWeight.w400);
        }
      case RegisterAppointmentEndHourPickerState:
        final _castedState = state as RegisterAppointmentEndHourPickerState;
        endHour = _castedState.hour;
        if (label == _castedState.label) {
          return customText.buildText(
              label: endHour,
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.valuesFontSize,
              fontWeight: FontWeight.w400);
        } else {
          return customText.buildText(
              label: initialHour,
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.valuesFontSize,
              fontWeight: FontWeight.w400);
        }
      case RegisterAppointmentHourErrorState:
        final _castedState = state as RegisterAppointmentHourErrorState;
        if (label == _castedState.label) {
          return customText.buildText(
              label: 'Escolha uma hora válida',
              color: Colors.red,
              fontSize: layoutConstrains.valuesFontSize,
              fontWeight: FontWeight.w400);
        } else if (label == 'Hora inicial') {
          return customText.buildText(
              label: initialHour,
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.widgetsFontSize,
              fontWeight: FontWeight.w400);
        } else {
          return customText.buildText(
              label: endHour,
              color: const Color(0xFFBDBDBD),
              fontSize: layoutConstrains.widgetsFontSize,
              fontWeight: FontWeight.w400);
        }
      default:
        if (label == 'Hora inicial') {
          return customText.buildText(
              label: initialHour,
              color: const Color(0xFF6B5347),
              fontSize: layoutConstrains.widgetsFontSize,
              fontWeight: FontWeight.w400);
        } else {
          return customText.buildText(
              label: endHour,
              color: const Color(0xFFBDBDBD),
              fontSize: layoutConstrains.widgetsFontSize,
              fontWeight: FontWeight.w400);
        }
    }
  }

  void getHour(BuildContext context, String label,
      RegisterAppointmentState state) async {
    final time = _mapStateToTimeOfDay(state: state, label: label);

    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if(label == 'Hora final'){
      BlocProvider.of<RegisterAppointmentBloc>(context)
          .add(RegisterAppointmentHourPickerEvent(hour: newTime, label: label, isSameDay: isSameDay, context: context, initialHour: initialHour));
    }
    else{
      BlocProvider.of<RegisterAppointmentBloc>(context)
          .add(RegisterAppointmentHourPickerEvent(hour: newTime, label: label, isSameDay: isSameDay, context: context));
    }
  }

  Widget _mapStateToMainButton(
      {required BuildContext context,
      required RegisterAppointmentState state}) {
    switch (state.runtimeType) {
      case RegisterAppointmentEndHourPickerState:
        return _buildMainButton(
            context: context,
            backgroundColor: const Color(0xFF6B5347),
            state: state);
      default:
        return _buildMainButton(
            context: context, backgroundColor: const Color(0xFFBDBDBD));
    }
  }

  Widget _buildTextInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: customText.buildText(
                label: 'Procedimento',
                color: const Color(0xFF6B5347),
                fontSize: layoutConstrains.widgetsFontSize,
                fontWeight: FontWeight.w400)),
        SizedBox(
          height: layoutConstrains.textInputHeight,
          width: layoutConstrains.textInputWidth,
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            controller: procedureController,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMainButton(
      {required context,
      required Color backgroundColor,
      RegisterAppointmentState? state}) {
    return SizedBox(
      width: layoutConstrains.widgetWidth,
      height: layoutConstrains.buttonHeigth,
      child: ElevatedButton(
        onPressed: () {
          if (state.runtimeType == RegisterAppointmentEndHourPickerState) {
            _registerEvent(context);
          }
        },
        child: Text(
          'Marcar consulta',
          style: TextStyle(
              color: Colors.white,
              fontSize: layoutConstrains.widgetsFontSize,
              fontFamily: 'Roboto'),
        ),
        style: ElevatedButton.styleFrom(
            primary: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(layoutConstrains.widgetsBorderRadius),
            )),
      ),
    );
  }

  TimeOfDay _mapStateToTimeOfDay(
      {required String label, required RegisterAppointmentState state}) {
    switch (state.runtimeType) {
      case RegisterAppointmentInitialHourPickerState:
        final _castedState = state as RegisterAppointmentInitialHourPickerState;
        if (label == _castedState.label) {
          return _castedState.timeOfDay;
        } else {
          return TimeOfDay.now();
        }
      case RegisterAppointmentEndHourPickerState:
        final _castedState = state as RegisterAppointmentEndHourPickerState;
        if (label == _castedState.label) {
          return _castedState.timeOfDay;
        } else {
          return TimeOfDay.now();
        }
      default:
        return TimeOfDay.now();
    }
  }

  void _registerEvent(BuildContext context) {
    BlocProvider.of<RegisterAppointmentBloc>(context).add(
        RegisterAppointmentRegisterEvent(
            dentistName: dropDownValuesMap['Doctor'] as String,
            pacientName: dropDownValuesMap['Patient'] as String,
            date: date,
            initialHour: initialHour,
            endHour: endHour,
            user: user,
            context: context,
            procedure: procedureController.text));
  }

  Color _mapStateToColor(
      {required RegisterAppointmentState state, required String label}) {
    if (state.runtimeType == RegisterAppointmentEndHourPickerState ||
        (label == 'Hora inicial' &&
            state.runtimeType != RegisterAppointmentHourErrorState) ||
        (label == 'Hora final' &&
            state.runtimeType == RegisterAppointmentInitialHourPickerState)) {
      return const Color(0xFF6B5347);
    } else if (state.runtimeType == RegisterAppointmentHourErrorState) {
      final _castedState = state as RegisterAppointmentHourErrorState;
      if (label == _castedState.label) {
        return Colors.red;
      } else {
        return const Color(0xFF6B5347);
      }
    } else {
      return const Color(0xFFBDBDBD);
    }
  }

  void _closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

class RegisterAppointmentLayoutConstrains {
  late double horizontalScreenPadding, verticalScreenPadding;
  double widgetsPadding = 10.0,
      bottomButtonPadding = 10.0,
      textToTextFieldPadding = 10.0,
      widgetHeight = 85.0,
      widgetWidth = 350.0,
      textInputHeight = 35.0,
      textInputWidth = 200.0,
      buttonHeigth = 55.0,
      widgetsFontSize = 16.0,
      valuesFontSize = 14.0,
      dropDownHeight = 35.0,
      labelFontSize = 18.0,
      titleFontSize = 20.0,
      iconSize = 20.0,
      widgetsToLabelPadding = 10.0,
      widgetsBorderRadius = 10.0;
}
