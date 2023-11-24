import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:samla_app/config/themes/new_style.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final IconData iconData;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Key? formKey;
  bool textAreaLike;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;

  CustomTextFormField(
      {super.key,
      required this.label,
      required this.iconData,
      this.controller,
      this.validator,
      this.formKey,
      this.keyboardType,
      this.textAreaLike = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLines: textAreaLike ? null : 1,
      keyboardType: textAreaLike ? TextInputType.multiline : keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: () {
        if (keyboardType == TextInputType.number) {
          return [FilteringTextInputFormatter.digitsOnly];
        } 
      }(),
      controller: controller,
      validator: validator,
      key: formKey,
      style: const TextStyle(color: themeDarkBlue, fontSize: 16),
      textAlignVertical: TextAlignVertical.center,
      cursorColor: themeDarkBlue.withOpacity(0.3),
      decoration: InputDecoration(
        contentPadding: textAreaLike ? const EdgeInsets.all(10.0) : null,
        isCollapsed: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusColor: themeDarkBlue.withOpacity(0.3),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: themeBlue.withOpacity(0.8), width: 1),
        ),
        fillColor: inputFieldColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: inputFieldColor.withOpacity(0.05), width: 0.1 ),
        ),
        labelText: label,
        labelStyle: TextStyle(color: inputFieldColor.withOpacity(0.05), fontSize: 14),
        prefixIcon: Align(
          widthFactor: 1.0,
          heightFactor: 1.0,
          child: Icon(
            iconData,
            color: themeBlue,
            size: 20,
          ),
        ),
      ),
    );
  }
}
