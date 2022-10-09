import 'package:check_postage_app/app/core/utils/color_util.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class StyleUtility {
  DropDownDecoratorProps dropdownDecorator(String label) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: outlinedInputDecoration(label),
    );
  }

  Column popupMenuDecoration(Widget popupWidget) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 12,
        ),
        Flexible(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 0.3,
                  blurRadius: 0.5,
                  offset: Offset(0, 0.2),
                  // Shadow position
                ),
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: popupWidget,
          ),
        ),
      ],
    );
  }

  InputDecoration outlinedInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      border: outlinedBorderStyle(),
      focusedBorder: outlinedBorderStyle(),
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
      shape: const StadiumBorder(),
      minimumSize: const Size.fromHeight(45),
    );
  }
}
