import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mumbot_v2/widgets/text_field_container.dart';

import './constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String initialValue;
  final String Function(String) validator;
  final AutovalidateMode autovalidate;
  final List<TextInputFormatter> inputFormatters;
  final MaxLengthEnforcement maxLengthEnforcement;
  final int maxLength;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final Function(String) onFieldSubmitted;
  final TextInputAction textInputAction;

  const RoundedInputField(
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.controller,
      this.initialValue,
      this.validator,
      this.autovalidate,
      this.inputFormatters,
      this.maxLengthEnforcement,
      this.maxLength,
      this.textInputAction,
      this.focusNode,
      this.onFieldSubmitted,
      this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        inputFormatters: inputFormatters,
        maxLengthEnforcement: maxLengthEnforcement,
        maxLength: maxLength,
        initialValue: initialValue,
        onChanged: onChanged,
        controller: controller,
        cursorColor: kPrimaryColor,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        autovalidateMode: autovalidate,
        validator: validator,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          counterText: "",
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
