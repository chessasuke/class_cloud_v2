import 'package:class_cloud/core/widgets/basic_text_field.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    required this.labelText,
    this.onChanged,
    this.initialValue = '',
    super.key,
  });

  final String labelText;
  final String initialValue;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return BasicTextField(
      autofocus: false,
      labelText: labelText,
      onChanged: onChanged,
      initialValue: initialValue,
    );
  }
}
