import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({
    Key? key,
    required this.controller,
    this.showPrefixIcon = true,
  }) : super(key: key);
  final TextEditingController controller;
  final bool showPrefixIcon;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: AppColors.primaryColor,
            ),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primaryColor,
        autocorrect: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          focusedBorder: AppUtils.borderSide,
          enabledBorder: AppUtils.borderSide,
          border: AppUtils.borderSide,
          prefixIcon: showPrefixIcon
              ? const Icon(
                  Icons.phone,
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          hintText: 'رقم الهاتف',
        ),
        validator: (value) {
          if (value != null && value.isEmpty) {
            return 'برجاء إدخال رقم الهاتف';
          } else if (value!.length != 11) {
            return 'برجاء إدخال رقم هاتف صحيح';
          } else if (value[0] != '0') {
            return 'برجاء إدخال رقم هاتف صحيح';
          } else if (value[1] != '1') {
            return 'برجاء إدخال رقم هاتف صحيح';
          }
          return null;
        },
      ),
    );
  }
}
