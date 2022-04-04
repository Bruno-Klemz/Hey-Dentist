import 'package:flutter/material.dart';

import 'CustomText.dart';

class CustomLabeledTextInput {
  final customText = CustomText();
  Widget buildTextInput({
    required String label,
    required BuildContext context,
    required TextEditingController controller,
    required double widgetHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText.buildText(
            label: label,
            color: const Color(0xFF6B5347),
            fontSize: 14,
            fontWeight: FontWeight.w400),
        SizedBox(
          height: widgetHeight,
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.center,
            controller: controller,
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Roboto',
            ),
          ),
        )
      ],
    );
  }
}
