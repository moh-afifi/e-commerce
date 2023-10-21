import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/auth/login/providers/login_provider.dart';
import 'package:wssal/features/root/screens/root_screen.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key, required this.formKey}) : super(key: key);
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
            final loginProvider = context.read<LoginProvider>();
            loginProvider.login(context).then(
              (value) {
                if (value != null) {
                  AppUtils.showSnackBar(context: context, message: value);
                } else {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      settings: const RouteSettings(name: "/Root"),
                      builder: (BuildContext context) {
                        return const RootScreen();
                      },
                    ),
                  );
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
          'تسجيل الدخول',
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
