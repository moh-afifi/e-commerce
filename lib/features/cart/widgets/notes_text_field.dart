import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/root/providers/root_provider.dart';

import '../../../core/widgets/plain_text_field.dart';

class NotesTextField extends StatelessWidget {
  const NotesTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shipping = context.read<RootProvider>().appSateModel?.shipping ?? 0;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          PlainTextField(
            controller: context.read<CartProvider>().notesController,
            requireValidate: false,
            hintText: 'ملاحظات',
            border: AppUtils.borderSide15,
          ),
          Visibility(
            visible: shipping != 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "تنويه : قد نقوم بإضافة مصاريف شحن : $shipping جنيه وفقا لمنطقة التغطية الخاصة بك",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.thirdColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
