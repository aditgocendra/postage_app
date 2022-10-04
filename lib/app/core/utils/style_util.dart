import 'package:check_postage_app/app/core/utils/color_util.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class StyleUtility {
  DropDownDecoratorProps dropdownDecorator(String label) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: outlinedInputDecoration(label),
    );
  }

  InputDecoration outlinedInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(fontSize: 12),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: outlinedBorderStyle(),
      focusedBorder: outlinedBorderStyle(),
      floatingLabelStyle: const TextStyle(color: primaryColor),
    );
  }

  OutlineInputBorder outlinedBorderStyle() {
    return const OutlineInputBorder(
      borderSide: BorderSide(width: 1.0, color: primaryColor),
      borderRadius: BorderRadius.all(
        Radius.circular(12.0),
      ),
    );
  }

  ButtonStyle buttonStylePill() {
    return ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      shape: const StadiumBorder(),
      minimumSize: const Size.fromHeight(45),
    );
  }
}
