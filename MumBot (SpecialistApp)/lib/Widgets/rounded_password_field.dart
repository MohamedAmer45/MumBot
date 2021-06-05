import 'package:flutter/material.dart';
import 'package:parenting_specialist/widgets/text_field_container.dart';

import './constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Function(String) onsaved;
  final String Function(String) validator;
  final AutovalidateMode autovalidate;
  final FocusNode focusNode;
  final Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;

  const RoundedPasswordField({
    this.hintText,
    this.controller,
    this.onsaved,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.autovalidate,
    this.textInputAction,
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
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onSaved: onsaved,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
