import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Data/Pacient/PacientModel.dart';
import 'package:hey_dentist/RegisterPatient/BLoC/RegisterPatientBloc.dart';
import 'package:hey_dentist/RegisterPatient/BLoC/RegisterPatientState.dart';

import '../../Components/CustomLabeledTextInput.dart';
import '../../Components/CustomText.dart';
import '../BLoC/RegisterPatientEvent.dart';

class RegisterPatient extends StatefulWidget {
  const RegisterPatient({Key? key}) : super(key: key);

  @override
  State<RegisterPatient> createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  final customText = CustomText();

  final customLabeledTextInput = CustomLabeledTextInput();

  final layoutConstrains = RegisterPatientLayoutConstrains();

  final formsVariablesLists = FormsVariablesLists();
  List<String> firstLabelsList = [];
  List<String> secondLabelsList = [];
  List<TextInputType> firstKeyboardTypeList = [];
  List<TextInputType> secondKeyboardTypeList = [];
  List<TextEditingController> firstControllerList = [];
  List<TextEditingController> secondControllerList = [];

  @override
  void initState() {
    super.initState();
    _initializeFormLists();
  }

  void _initializeFormLists() {
    firstLabelsList = formsVariablesLists.getFirstLabelsList();
    secondLabelsList = formsVariablesLists.getSecondLabelsList();
    firstControllerList = formsVariablesLists.getControllerList();

    secondControllerList = formsVariablesLists.getControllerList();
  }

  @override
  Widget build(BuildContext context) {
    final verticalScreenPadding = MediaQuery.of(context).size.height * 0.025;
    final horizontalScreenPadding = MediaQuery.of(context).size.width * 0.05;

    return GestureDetector(
      onTap: () {
        _closeKeyboard();
      },
      onVerticalDragStart: (DragStartDetails details) {
        _closeKeyboard();
      },
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalScreenPadding,
              vertical: verticalScreenPadding),
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: _buildFormsColumn(context)),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFFD1B66F),
      title: const Text('Novo Paciente'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Column _buildFormsColumn(BuildContext context) {
    return Column(
      children: [
        customText.buildText(
            label: 'Informações Básicas',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
                top: layoutConstrains.firstRowToMainLabelPadding),
            child: ListView.builder(
                shrinkWrap: false,
                physics: MediaQuery.of(context).viewInsets.bottom != 0
                    ? null
                    : const NeverScrollableScrollPhysics(),
                itemCount: 8,
                itemBuilder: _buildListViewItems),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: layoutConstrains.widgetsPadding),
            child: BlocBuilder<RegisterPatientBloc, RegisterPatientState>(
              builder: (BuildContext context, RegisterPatientState state) {
                return _mapStateToErrorMessage(state);
              },
            )),
        Padding(
          padding: EdgeInsets.only(top: layoutConstrains.widgetsPadding),
          child: _buildMainButton(
              label: 'Salvar Contato',
              context: context,
              backgroundColor: const Color(0xFFD1B66F),
              routeName: 'RegisterPatientToHome'),
        ),
        Padding(
          padding: EdgeInsets.only(top: layoutConstrains.widgetsPadding),
          child: _buildMainButton(
              label: 'Seguir para anamnese',
              context: context,
              backgroundColor: const Color(0xFF6B5347),
              routeName: 'RegisterPatientToFormTwo'),
        ),
      ],
    );
  }

  Text _mapStateToErrorMessage(RegisterPatientState state) {
    switch (state.runtimeType) {
      case RegisterPatientErrorState:
        final castedState = state as RegisterPatientErrorState;
        return customText.buildText(
            label: castedState.errorMessage,
            color: Colors.red,
            fontSize: 14,
            fontWeight: FontWeight.w500);
      default:
        return const Text('');
    }
  }

  Widget _buildMainButton(
      {required String label,
      required Color backgroundColor,
      required String routeName,
      required context}) {
    return SizedBox(
      width: layoutConstrains.buttonWidth,
      height: layoutConstrains.buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          Pacient newPacient = getPacientModel();
          BlocProvider.of<RegisterPatientBloc>(context).add(
              RegisterPatientSaveAndSwitchScreenEvent(
                  context: context, model: newPacient, routeName: routeName));
        },
        child: Text(
          label,
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

  Widget _buildListViewItems(BuildContext context, int index) {
    return Padding(
      padding: index != 0
          ? EdgeInsets.only(top: layoutConstrains.widgetsPadding * 0.8)
          : const EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: layoutConstrains.widgetsPadding),
              child: customLabeledTextInput.buildTextInput(
                  label: firstLabelsList[index],
                  context: context,
                  controller: firstControllerList[index],
                  widgetHeight: layoutConstrains.widgetHeight),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: layoutConstrains.widgetsPadding),
              child: customLabeledTextInput.buildTextInput(
                  label: secondLabelsList[index],
                  context: context,
                  controller: secondControllerList[index],
                  widgetHeight: layoutConstrains.widgetHeight),
            ),
          ),
        ],
      ),
    );
  }

  Pacient getPacientModel() {
    final pacient = Pacient(
        name: firstControllerList[0].text,
        lastName: secondControllerList[0].text,
        id: firstControllerList[1].text,
        cpf: firstControllerList[2].text,
        celular: firstControllerList[3].text,
        enderecoResidencial: firstControllerList[4].text,
        nacionalidade: firstControllerList[5].text,
        orgaoExpedidor: firstControllerList[6].text,
        profissao: firstControllerList[7].text,
        rg: secondControllerList[1].text,
        birthDay: secondControllerList[2].text,
        estadoCivil: secondControllerList[3].text,
        indicadoPor: secondControllerList[4].text,
        telefone: secondControllerList[5].text,
        enderecoProfissional: secondControllerList[6].text,
        sexo: secondControllerList[7].text);
    return pacient;
  }

  void _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

class RegisterPatientLayoutConstrains {
  double widgetsPadding = 15.0,
      textToTextFieldPadding = 10.0,
      firstRowToMainLabelPadding = 25.0,
      widgetHeight = 30.0,
      buttonWidth = 320.0,
      buttonHeight = 46.0,
      widgetsFontSize = 16.0,
      widgetsBorderRadius = 10.0;
}

class FormsVariablesLists {
  List<String> getFirstLabelsList() {
    return [
      '* Nome',
      '* Num Prontuário',
      'CPF',
      'Celular',
      'End Residencial',
      "Nacionalidade",
      'Orgão Expedidor',
      'Profissão'
    ];
  }

  List<String> getSecondLabelsList() {
    return [
      '* Sobrenome',
      'RG',
      'Data de nascimento',
      'Estado civil',
      'Indicado por',
      'Telefone',
      'End Profissional',
      'Gênero'
    ];
  }

  List<TextEditingController> getControllerList() {
    List<TextEditingController> controllerList = [];
    for (int i = 0; i < 8; i++) {
      controllerList.add(TextEditingController());
    }
    return controllerList;
  }
}
