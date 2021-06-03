import 'package:flutter/material.dart';

import 'package:mumbot_v2/screens/components/text_field_container.dart';

import './constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Function(String) onsaved;
  final String Function(String) validator;
  final AutovalidateMode autovalidate;

  const RoundedPasswordField({
    this.hintText,
    this.controller,
    this.onsaved,
    this.validator,
    this.autovalidate,
    Key key,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        controller: controller,
        autovalidateMode: autovalidate,
        validator: validator,
        onSaved: onsaved,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          // suffixIcon: Icon(
          //   Icons.visibility,
          //   color: kPrimaryColor,
          // ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
