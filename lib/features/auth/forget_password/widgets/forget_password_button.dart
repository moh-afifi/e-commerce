import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/auth/forget_password/providers/forget_password_provider.dart';

class ForgetPasswordButton extends StatelessWidget {
  const ForgetPasswordButton({Key? key, required this.formKey})
      : super(key: key);
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          if (formKey.currentState!.validate()) {
            final provider = context.read<ForgetPasswordProvider>();
            provider.forgetPassword().then(
              (value) {
                if (value != null) {
                  AppUtils.showSnackBar(context: context, message: value);
                } else {
                  AppUtils.showSnackBar(context: context, message: 'تم تغيير كلمة المرور بنجاح',isFailure: false);
                  Navigator.pop(context);
                }
              },
            );
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.all(10),
        ),
        child: const Text(
          'تغيير كلمة المرور',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
