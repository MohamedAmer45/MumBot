import 'package:flutter/material.dart';
import 'package:mumbot_v2/screens/components/text_field_container.dart';

import './constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String initialValue;
  final String Function(String) validator;
  final AutovalidateMode autovalidate;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.validator,
    this.autovalidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        controller: controller,
        cursorColor: kPrimaryColor,
        autovalidateMode: autovalidate,
        validator: validator,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
