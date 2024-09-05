import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant/Colors/Color.dart';


class CustomCheckbox extends StatelessWidget {
  final String label;
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({
    required this.label,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
        ),
        Text(label),
      ],
    );
  }
}


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

Widget defaultTextFormDecorated({
  required TextEditingController controller,
  required String label,
  required String hintText,
  required TextInputType type,
  required FormFieldSetter<String> onSubmit,
  required FormFieldValidator<String> validate,
  required ValueChanged<String> onChange,
  required VoidCallback suffixPressed,
  required IconData suffixicon,
  IconData? prefixicon,
  Color? borderColor, // Border color
  double? borderRadius, // Border radius
  Color? fillColor, // Fill color
  Color? hintColor, // Hint text color
  Color? labelColor, // Label text color
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
      suffixIcon: IconButton(
        icon: Icon(suffixicon),
        onPressed: suffixPressed,
      ),
      prefixIcon: prefixicon != null ? Icon(prefixicon) : null,
      filled: true, // Enable filled background
      fillColor: fillColor ?? Colors.white, // Set the fill color, default to white if not provided
      hintStyle: TextStyle(color: hintColor ?? Colors.grey), // Customize hint text color
      labelStyle: TextStyle(color: labelColor ?? Colors.black), // Customize label text color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        borderSide: BorderSide(color: borderColor ?? Colors.grey),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        borderSide: BorderSide(color: borderColor ?? Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
        borderSide: BorderSide(color: borderColor ?? Colors.blue),
      ),
    ),
    onFieldSubmitted: onSubmit,
    validator: validate,
    onChanged: onChange,
  );
}
