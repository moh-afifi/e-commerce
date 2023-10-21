import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/plain_text_field.dart';
import 'package:wssal/core/widgets/text_field_label.dart';
import 'package:wssal/features/auth/register/data/models/entity_model.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';
import 'package:wssal/features/auth/register/widgets/entity_drop_down.dart';
import 'package:wssal/features/auth/register/widgets/register_button.dart';

class RegisterTwo extends StatelessWidget {
  const RegisterTwo({Key? key, required this.onPressed}) : super(key: key);
  final void Function() onPressed;
  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          const TextFieldLabel(
            label: 'اسم المنشأة',
          ),
          const SizedBox(
            height: 10,
          ),
          PlainTextField(
            controller: registerProvider.placeNameController,
            errorText: 'برجاء إدخال اسم المنشأة',
            hintText: 'اسم المنشأة',
          ),
          const SizedBox(
            height: 10,
          ),
          const TextFieldLabel(
            label: 'نوع المنشأة',
          ),
          const SizedBox(
            height: 10,
          ),
          const EntityDropDown(),
          const SizedBox(
            height: 25,
          ),
          const Spacer(),
          Selector<RegisterProvider, Entity?>(
            shouldRebuild: (previous, next) => previous != next,
            selector: (context, provider) => provider.chosenPlaceType,
            builder: (context, chosenPlaceType, _) {
              return RegisterButton(
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if (_formKey.currentState!.validate()) {
                    if (chosenPlaceType == null) {
                      AppUtils.showSnackBar(
                          context: context,
                          message: 'الرجاء اختيار نوع المنشأة');
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
