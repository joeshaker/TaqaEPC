import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant/Colors/Color.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required String label,
  required String hintText,
  IconData? prefixicon,
  required TextInputType type,
  required void Function(String?) onSubmit,
  required String? Function(String? value) validate,
  required Function(String? value) onChange,
  bool isPassword = false,
  IconData? suffixicon,
  required Function() suffixPressed,
}) {
  return TextFormField(
    controller: controller,
    validator: validate,
    onChanged: onChange,
    obscureText: isPassword,
    keyboardType: type,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      labelStyle: TextStyle(
          fontSize: 25,
        color: LabelTextFeildColor
      ),
      //border: OutlineInputBorder(),
      labelText: label,
      hintText: hintText,
      prefixIcon: prefixicon != null
          ? Icon(
        prefixicon,
      )
          : null,
      suffixIcon: suffixicon != null
          ? IconButton(
        onPressed: suffixPressed,
        icon: Icon(
          suffixicon,
          color: IconColor,
        ),
      )
          : null,
    ),
  );
}