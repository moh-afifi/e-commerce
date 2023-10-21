import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
