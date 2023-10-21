import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/core/widgets/password_text_field.dart';
import 'package:wssal/core/widgets/phone_text_field.dart';
import 'package:wssal/features/auth/forget_password/screens/forget_password_screen.dart';
import 'package:wssal/features/auth/login/providers/login_provider.dart';
import 'package:wssal/features/auth/login/widgets/login_button.dart';
import 'package:wssal/features/auth/login/widgets/login_footer.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child:  GlobalScaffold(
        body: Builder(
          builder: (context) {
            final loginProvider = context.read<LoginProvider>();
            return Selector<LoginProvider, bool>(
              shouldRebuild: (previous, next) => previous != next,
              selector: (context, provider) => provider.loading,
              builder: (context, loading, _) {
                return ModalProgressHUD(
                  inAsyncCall: loading,
                  progressIndicator: const AppLoader(),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Image.asset(
                            "assets/images/logo-word.png",
                            height: MediaQuery.of(context).size.height / 4,
                          ),
                        ),
                        PhoneTextField(
                          controller: loginProvider.phoneController,
                        ),
                        const SizedBox(height: 20),
                        Selector<LoginProvider, bool>(
                          shouldRebuild: (previous, next) => previous != next,
                          selector: (context, provider) =>
                              provider.showPassword,
                          builder: (context, showPassword, _) {
                            return PasswordTextField(
                              controller: loginProvider.passwordController,
                              showPassword: showPassword,
                              showHidePassword: () =>
                                  loginProvider.showHidePassword(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const ForgetPasswordScreen();
                              },
                            ),
                          ),
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'نسيت كلمة المرور؟',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondColor,
                                decoration: TextDecoration.underline,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        LoginButton(formKey: _formKey),
                        const SizedBox(
                          height: 20,
                        ),
                        const LoginFooter(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
