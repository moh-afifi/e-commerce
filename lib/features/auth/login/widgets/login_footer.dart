import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/auth/register/screens/register_screen.dart';

import '../../register/providers/register_provider.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'ليس لديك حساب؟',
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () async {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ChangeNotifierProvider(
                    create: (_) => RegisterProvider(),
                    child: const RegisterScreen(),
                  );
                },
              ),
            );
          },
          child: const Text(
            'حساب جديد',
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
