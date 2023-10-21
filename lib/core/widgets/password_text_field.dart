import 'package:flutter/material.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    Key? key,
    required this.controller,
    required this.showHidePassword,
    required this.showPassword,
    this.showPrefixIcon = true,
  }) : super(key: key);
  final TextEditingController controller;
  final bool showPassword;
  final VoidCallback showHidePassword;
  final bool showPrefixIcon;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: AppColors.primaryColor)),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primaryColor,
        autocorrect: true,
        obscureText: !showPassword,
        decoration: InputDecoration(
          focusedBorder: AppUtils.borderSide,
          enabledBorder: AppUtils.borderSide,
          border: AppUtils.borderSide,
          prefixIcon: showPrefixIcon
              ? const Icon(
                  Icons.lock_open,
                )
              : null,
          suffixIcon: InkWell(
            onTap: showHidePassword,
            child: Icon(
              showPassword ? Icons.visibility_off_outlined : Icons.visibility,
              color: AppColors.primaryColor,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          hintText: 'كلمة المرور',
        ),
        validator: (val) {
          if (val != null && val.isEmpty) {
            return 'برجاء إدخال كلمة المرور';
          }
          return null;
        },
      ),
    );
  }
}
