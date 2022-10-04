import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class StyleUtility {
  DropDownDecoratorProps dropdownDecorator(String label) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
