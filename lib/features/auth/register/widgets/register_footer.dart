import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'هل لديك حساب؟',
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () => Navigator.pop(context),
          child: const Text(
            'تسجيل الدخول',
            style: TextStyle(
              color: AppColors.thirdColor,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
