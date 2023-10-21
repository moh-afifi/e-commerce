import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/password_text_field.dart';
import 'package:wssal/core/widgets/phone_text_field.dart';
import 'package:wssal/core/widgets/plain_text_field.dart';
import 'package:wssal/core/widgets/text_field_label.dart';
import 'package:wssal/features/auth/register/data/models/entity_model.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';
import 'package:wssal/features/auth/register/widgets/area_drop_down.dart';
import 'package:wssal/features/auth/register/widgets/register_button.dart';

import '../../../../core/utils/color_utils.dart';

class RegisterOne extends StatelessWidget {
  const RegisterOne({Key? key, required this.onPressed}) : super(key: key);
  final void Function() onPressed;
  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const TextFieldLabel(label: 'الاسم'),
                const SizedBox(
                  height: 5,
                ),
                PlainTextField(
                  controller: registerProvider.nameController,
                  errorText: 'برجاء إدخال الاسم',
                  hintText: 'الاسم',
                ),
                const SizedBox(
                  height: 10,
                ),
                const TextFieldLabel(label: 'رقم الهاتف'),
                const SizedBox(
                  height: 5,
                ),
                PhoneTextField(
                    controller: registerProvider.phoneController,
                    showPrefixIcon: false),
                const SizedBox(
                  height: 10,
                ),
                const TextFieldLabel(label: 'كلمة المرور'),
                const SizedBox(
                  height: 5,
                ),
                Selector<RegisterProvider, bool>(
                  shouldRebuild: (previous, next) => previous != next,
                  selector: (context, provider) => provider.showPassword,
                  builder: (context, showPassword, _) {
                    return PasswordTextField(
                      controller: registerProvider.passwordController,
                      showHidePassword: () =>
                          registerProvider.showHidePassword(),
                      showPassword: showPassword,
                      showPrefixIcon: false,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'منطقة التغطية',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const AreaDropDown(),
                const SizedBox(
                  height: 10,
                ),
                Selector<RegisterProvider, Entity?>(
                  shouldRebuild: (previous, next) => previous != next,
                  selector: (context, provider) => provider.chosenArea,
                  builder: (context, chosenArea, _) {
                    return Visibility(
                      visible: chosenArea?.minimumPrice != null,
                      child: Text(
                        'الحد الأدنى للطلب ${chosenArea?.minimumPrice.toString()} جنيه ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Selector<RegisterProvider, Entity?>(
            shouldRebuild: (previous, next) => previous != next,
            selector: (context, provider) => provider.chosenArea,
            builder: (context, chosenArea, _) {
              return RegisterButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState!.validate()) {
                    if (chosenArea == null) {
                      AppUtils.showSnackBar(
                          context: context,
                          message: 'الرجاء اختيار منطقة التغطية');
                    } else {
                      onPressed();
                    }
                  }
                },
                label: 'متابعة',
              );
            },
          ),
        ],
      ),
    );
  }
}
