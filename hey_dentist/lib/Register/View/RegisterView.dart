import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hey_dentist/Register/BLoC/RegisterBloc.dart';

import '../BLoC/RegisterEvent.dart';
import '../BLoC/RegisterState.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final layoutConstrains = RegisterLayoutConstrains();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    layoutConstrains.logoContainerSize =
        MediaQuery.of(context).size.height * 0.4;

    layoutConstrains.backgroundInfoContainerSize =
        MediaQuery.of(context).size.height * 0.45;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: MediaQuery.of(context).viewInsets.bottom != 0
            ? null
            : const NeverScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _buildLogoContainer(context),
              Expanded(child: _buildInfoBackgroundContainer(context))
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLogoContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: layoutConstrains.logoContainerSize,
      color: const Color(0xFF6B5347),
    );
  }

  Container _buildInfoBackgroundContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
          child: Padding(
        padding: EdgeInsets.all(layoutConstrains.widgetToBorderPadding),
        child: _buildInfoContainer(context),
      )),
    );
  }

  Container _buildInfoContainer(BuildContext context) {
    layoutConstrains.infosContainerHeight =
        MediaQuery.of(context).size.height * 0.7;
    layoutConstrains.infosContainerWidth =
        MediaQuery.of(context).size.width * 0.6;

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 5, color: const Color(0xFF6B5347)),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: layoutConstrains.widgetToBorderPadding,
            vertical: layoutConstrains.widgetToBorderPadding),
        child: _buildInfoColumn(context),
      ),
    );
  }

  Column _buildInfoColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BlocBuilder<RegisterBloc, RegisterState>(
          builder: (BuildContext context, RegisterState state) {
            return _mapStateToError(context, state);
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: layoutConstrains.widgetPadding),
          child: _buildTextInput(
              label: "email",
              context: context,
              keyboardType: TextInputType.emailAddress,
              controller: emailController),
        ),
        Padding(
          padding: EdgeInsets.only(top: layoutConstrains.widgetPadding),
          child: _buildTextInput(
              label: "senha",
              context: context,
              keyboardType: TextInputType.text,
              controller: passwordController),
        ),
        Padding(
          padding: EdgeInsets.only(top: layoutConstrains.widgetPadding),
          child: _buildMainButton(
              label: "Criar cadastro",
              backgroundColor: const Color(0xFF6B5347),
              context: context,
              event: RegisterCreateDentistEvent(
                  email: emailController.text,
                  password: passwordController.text,
                  context: context)),
        ),
      ],
    );
  }

  Text _mapStateToError(BuildContext context, RegisterState state) {
    switch (state.runtimeType) {
      case RegisterErrorState:
        final _castedState = state as RegisterErrorState;
        return _buildText(_castedState.errorMessage, Colors.red);
      default:
        return _buildText("", Colors.white);
    }
  }

  Text _buildText(String label, Color color) {
    return Text(label,
        style: TextStyle(
            color: color,
            fontSize: layoutConstrains.widgetsFontSize,
            fontFamily: 'Roboto'));
  }

  Widget _buildTextInput(
      {required String label,
      required TextEditingController controller,
      required BuildContext context,
      required TextInputType keyboardType}) {
    return SizedBox(
        height: layoutConstrains.widgetsHeight,
        width: layoutConstrains.widgetsWidth,
        child: TextFormField(
          obscureText: label == 'senha' ? true : false,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              labelText: label,
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6B5347))),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF6B5347)))),
          style: TextStyle(
            color: Colors.black,
            fontSize: layoutConstrains.widgetsFontSize,
            fontWeight: FontWeight.w100,
            fontFamily: 'Roboto',
          ),
        ));
  }

  Widget _buildMainButton(
      {required String label,
      required Color backgroundColor,
      required RegisterEvent event,
      required context}) {
    return SizedBox(
      width: layoutConstrains.widgetsWidth,
      height: layoutConstrains.widgetsHeight,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<RegisterBloc>(context).add(event);
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
}

class RegisterLayoutConstrains {
  double? logoContainerSize,
      backgroundInfoContainerSize,
      infosContainerHeight,
      infosContainerWidth;
  double widgetsWidth = 256.0,
      widgetsHeight = 46.0,
      widgetsFontSize = 14.0,
      widgetPadding = 18.0,
      widgetToBorderPadding = 30,
      widgetsBorderRadius = 5.0;
}
