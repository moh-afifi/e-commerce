import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/app_button.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/phone_text_field.dart';
import 'package:wssal/core/widgets/plain_text_field.dart';
import 'package:wssal/core/widgets/text_field_label.dart';
import 'package:wssal/features/support/providers/support_provider.dart';
class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);
  static final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<SupportProvider>();
    return  GlobalScaffold(
      appBar: const GlobalAppBar(title: 'شكوى أو اقتراح'),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const TextFieldLabel(
                      label: 'رقم الهاتف',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PhoneTextField(
                      controller: provider.phoneController,
                      showPrefixIcon: false,
                    ),
                    //---------------------------------------------
                    const SizedBox(height: 15),
                    const TextFieldLabel(
                      label: 'عنوان المشكلة',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PlainTextField(
                      controller: provider.subjectController,
                      hintText: 'عنوان المشكلة',
                      requireValidate: true,
                      errorText: 'برجاء إدخال عنوان المشكلة',
                    ),
                    //---------------------------------------------
                    const SizedBox(height: 15),
                    const TextFieldLabel(
                      label: 'وصف المشكلة',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    PlainTextField(
                      controller: provider.messageController,
                      hintText: 'وصف المشكلة',
                      enableMultiLines: true,
                      errorText: 'برجاء إدخال وصف المشكلة',
                    ),
                  ],
                ),
              ),
              Consumer<SupportProvider>(
                builder: (_, provider, __) {
                  return KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                    return Visibility(
                      visible: !isKeyboardVisible,
                      child: AppButton(
                        isBusy: provider.loading,
                        label: 'إرسال',
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_formKey.currentState!.validate()) {
                            provider.sendMessage().then((error) {
                              final success = error == null;
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: success
                                    ? DialogType.success
                                    : DialogType.error,
                                title: success
                                    ? 'تم الإرسال بنجاح'
                                    : 'حدث خطأ في البيانات',
                                desc: success
                                    ? 'سيتم التواصل معك في أقرب وقت'
                                    : null,
                                btnOkOnPress: () {},
                                btnOkText: 'موافق',
                              ).show().then((value) => Navigator.pop(context));
                            });
                          }
                        },
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
