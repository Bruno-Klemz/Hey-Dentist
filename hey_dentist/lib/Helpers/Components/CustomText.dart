import 'package:flutter/material.dart';

class CustomText {
  Text buildText(
      {required String label,
      required Color color,
      required double fontSize,
      required FontWeight fontWeight}) {
    return Text(label,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'Roboto',
          fontWeight: fontWeight,
        ));
  }
}
