import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/core/widgets/password_text_field.dart';
import 'package:wssal/core/widgets/phone_text_field.dart';
import 'package:wssal/features/auth/forget_password/providers/forget_password_provider.dart';
import 'package:wssal/features/auth/forget_password/widgets/forget_password_button.dart';
class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgetPasswordProvider(),
      child:  GlobalScaffold(
        body: Builder(
          builder: (context) {
            final forgetPasswordProvider =
                context.read<ForgetPasswordProvider>();
            return Selector<ForgetPasswordProvider, bool>(
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
                          controller: forgetPasswordProvider.phoneController,
                        ),
                        const SizedBox(height: 20),
                        Selector<ForgetPasswordProvider, bool>(
                          shouldRebuild: (previous, next) => previous != next,
                          selector: (context, provider) =>
                              provider.showPassword,
                          builder: (context, showPassword, _) {
                            return PasswordTextField(
                              controller:
                                  forgetPasswordProvider.passwordController,
                              showPassword: showPassword,
                              showHidePassword: () =>
                                  forgetPasswordProvider.showHidePassword(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ForgetPasswordButton(formKey: _formKey),

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
