import 'package:flutter/material.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';

class PlainTextField extends StatelessWidget {
  const PlainTextField({
    Key? key,
    required this.controller,
    this.errorText,
    this.hintText,
    this.hintColor,
    this.suffix,
    this.onEditingComplete,
    this.border,
    this.enableMultiLines=false,
    this.enabled = true,
    this.requireValidate = true,
  }) : super(key: key);
  final TextEditingController controller;
  final String? hintText;
  final bool enabled;
  final bool enableMultiLines;
  final bool requireValidate;
  final InputBorder? border ;
  final String? errorText;
  final Color? hintColor;
  final Widget? suffix;
  final void Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: AppColors.primaryColor)),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        maxLines:enableMultiLines? 4 :1,
        cursorColor: AppColors.primaryColor,
        autocorrect: true,
        decoration: InputDecoration(
          focusedBorder:border?? AppUtils.borderSide,
          enabledBorder:border?? AppUtils.borderSide,
          disabledBorder: border??AppUtils.borderSide,
          border:border?? AppUtils.borderSide,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          hintText: hintText,
          suffixIcon: suffix,
          // suffix: suffix,
          hintStyle: TextStyle(
            color: hintColor ?? Colors.grey,
          ),
        ),
        onEditingComplete: onEditingComplete,
        validator: requireValidate
            ? (val) {
                if (val != null && val.trim().isEmpty) {
                  return errorText;
                }
                return null;
              }
            : null,
      ),
    );
  }
}
