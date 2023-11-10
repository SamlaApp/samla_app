import 'package:flutter/material.dart';
import 'package:samla_app/config/themes/common_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final IconData iconData;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Key? formKey;
  bool textArealike;

  CustomTextFormField(
      {super.key,
      required this.label,
      required this.iconData,
      this.controller,
      this.validator,
      this.formKey,
      this.textArealike = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      child: TextFormField(
        maxLines: textArealike ? null : 1,
        keyboardType: textArealike ? TextInputType.multiline : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        key: formKey,
        style: TextStyle(color: theme_darkblue, fontSize: 16),
        textAlignVertical: TextAlignVertical.center,
        cursorColor: theme_darkblue.withOpacity(0.3),
        decoration: InputDecoration(
          contentPadding: textArealike ? EdgeInsets.all(10.0) : null,
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          fillColor: inputField_color,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          labelText: label,
          labelStyle:
              TextStyle(color: inputField_color.withOpacity(0.3), fontSize: 14),
          prefixIcon: Align(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: Icon(
              iconData,
              color: theme_green,
            ),
          ),
        ),
      ),
    );
  }
}
