import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/plain_text_field.dart';
import 'package:wssal/core/widgets/text_field_label.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';
import 'package:wssal/features/auth/register/widgets/image_view.dart';
import 'package:wssal/features/auth/register/widgets/map_address_location.dart';
import 'package:wssal/features/auth/register/widgets/register_button.dart';

class RegisterThree extends StatelessWidget {
  const RegisterThree({Key? key, required this.onPressed}) : super(key: key);
  final void Function() onPressed;
  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextFieldLabel(
              label: 'العنوان بالتفصيل',
            ),
            const SizedBox(height: 10),
            PlainTextField(
              controller: registerProvider.locationController,
              errorText: 'برجاء إدخال العنوان بالتفصيل',
              hintText: 'العنوان بالتفصيل',
            ),
            const MapAddressSelection(),
            const TextFieldLabel(
              label: 'ارفاق صورة واضحة لنشاطك',
            ),
            const SizedBox(height: 20),
            const ImageView(),
            const SizedBox(height: 20),
            RegisterButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_formKey.currentState!.validate()) {
                  if (registerProvider.image == null) {
                    AppUtils.showSnackBar(
                        context: context, message: 'الرجاء إدخال الصورة');
                  } else {
                    onPressed();
                  }
                }
              },
              label: 'تسجيل الحساب',
            ),
          ],
        ),
      ),
    );
  }
}
