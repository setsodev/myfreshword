import 'dart:ui';

import 'package:flutter/material.dart';

import './responsive_ui.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData icon;
  final FormFieldValidator validator;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;

  CustomTextField(
      {this.hint,
      this.textEditingController,
      this.keyboardType,
      this.icon,
      this.obscureText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
        validator: validator,
        controller: textEditingController,
        keyboardType: keyboardType,
        cursorColor: Colors.red[500],
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.red[500], size: 20),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class CustomDropdownButton extends StatelessWidget {
  final String dropdownValue;
  final List item;
  final onchanged;
  final IconData icon;
  final Text hint;
  final bool isExpanded;
  final TextStyle style;

  CustomDropdownButton(
      {this.dropdownValue,
      this.item,
      this.onchanged,
      this.icon,
      this.hint,
      this.isExpanded,
      this.style});
  double _width;

  double _pixelRatio;

  bool large;

  bool medium;

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: large ? 12 : (medium ? 10 : 8),
        child: DropdownButton<String>(
          value: dropdownValue,
          onChanged: onchanged,
          items: item,
          // icon:Icon(icon, color: Colors.red[500], size: 20,),
          hint: hint,
          isExpanded: isExpanded,
          // underline: ,
          // style:TextStyle(decorationStyle: InputDecoration())
        ));
  }
}
