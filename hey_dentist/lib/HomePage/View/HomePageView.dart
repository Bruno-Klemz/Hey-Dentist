import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../BLoC/HomePageBloc.dart';
import '../BLoC/HomePageEvent.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final layoutConstrains = HomePageLayoutConstrains();

  @override
  Widget build(BuildContext context) {
    layoutConstrains.logoContainerSize =
        MediaQuery.of(context).size.height * 0.4;

    layoutConstrains.backgroundInfoContainerSize =
        MediaQuery.of(context).size.height * 0.6;

    return Scaffold(
      body: SingleChildScrollView(
        physics: MediaQuery.of(context).viewInsets.bottom != 0
            ? null
            : const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            _buildLogoContainer(context),
            _buildInfoBackgroundContainer(context)
          ],
        ),
      ),
    );
  }

  Container _buildLogoContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: layoutConstrains.logoContainerSize,
      color: const Color(0xFF6B5347),
      child: Center(
        child: Image.asset('assets/mainImage1.jpg'),
      ),
    );
  }

  Container _buildInfoBackgroundContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: layoutConstrains.backgroundInfoContainerSize,
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
        padding: EdgeInsets.all(layoutConstrains.widgetToBorderPadding),
        child: _buildInfoColumn(context),
      ),
    );
  }

  Column _buildInfoColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildMainButton(
            label: "Cadastrar paciente",
            backgroundColor: const Color(0xFFD1B66F),
            context: context,
            event: HomePageSwitchToNextScreenEvent(
                context: context, routeName: 'HomeToRegisterPatient')),
        Padding(
          padding: EdgeInsets.only(top: layoutConstrains.widgetPadding),
          child: _buildMainButton(
              label: "Marcar consulta",
              backgroundColor: const Color(0xFFD1B66F),
              context: context,
              event: HomePageSwitchToNextScreenEvent(
                  context: context, routeName: 'HomeToRegisterAppointment')),
        ),
        Padding(
          padding: EdgeInsets.only(top: layoutConstrains.widgetPadding),
          child: _buildMainButton(
              label: "Gerenciar pacientes",
              backgroundColor: const Color(0xFF6B5347),
              context: context,
              event: HomePageSwitchToNextScreenEvent(
                  context: context, routeName: 'HomeToManagePatient')),
        ),
        Padding(
          padding: EdgeInsets.only(top: layoutConstrains.widgetPadding),
          child: _buildMainButton(
              label: "Visualizar consultas",
              backgroundColor: const Color(0xFF6B5347),
              context: context,
              event: HomePageSwitchToNextScreenEvent(
                  context: context, routeName: 'HomeToVisualizeAppointment')),
        ),
      ],
    );
  }

  Text _buildText(String label, Color color) {
    return Text(label,
        style: TextStyle(
            color: color,
            fontSize: layoutConstrains.widgetsFontSize,
            fontFamily: 'Roboto'));
  }

  Widget _buildMainButton(
      {required String label,
      required Color backgroundColor,
      required HomePageEvent event,
      required context}) {
    return SizedBox(
      width: layoutConstrains.widgetsWidth,
      height: layoutConstrains.widgetsHeight,
      child: ElevatedButton(
        onPressed: () {
          BlocProvider.of<HomePageBloc>(context).add(event);
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

class HomePageLayoutConstrains {
  double? logoContainerSize,
      backgroundInfoContainerSize,
      infosContainerHeight,
      infosContainerWidth;
  double widgetsWidth = 256.0,
      widgetsHeight = 46.0,
      widgetsFontSize = 14.0,
      widgetPadding = 18.0,
      widgetToBorderPadding = 30,
      widgetsBorderRadius = 5.0,
      dividerHeight = 2.0;
}
