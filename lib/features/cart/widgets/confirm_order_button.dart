import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/app_button.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/orders/screens/orders_screen.dart';
import 'package:wssal/features/root/providers/root_provider.dart';

class ConfirmOrderButton extends StatelessWidget {
  const ConfirmOrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    return Consumer<CartProvider>(
      builder: (_, provider, __) {
        return AppButton(
          label: 'تأكيد الطلب',
          isBusy: provider.createOrderLoading,
          margin: const EdgeInsets.symmetric(vertical: 15),
          fontWeight: FontWeight.w600,
          padding: const EdgeInsets.symmetric(vertical: 10),
          onPressed: provider.selectedAddressId == null ||
                  provider.selectedTimeId == null
              ? null
              : () async {
                  await cartProvider.createOrder().then(
                        (error) => AwesomeDialog(
                          context: context,
                          animType: AnimType.scale,
                          dialogType: error == null
                              ? DialogType.success
                              : DialogType.error,
                          desc: error ?? 'تم إنشاء الطلب بنجاح',
                          btnOkOnPress: () {
                            if (error == null) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return const OrdersScreen();
                                  },
                                ),
                              );
                              context.read<RootProvider>().changeIndex(0);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          btnOkText: 'موافق',
                          dismissOnBackKeyPress: false,
                          dismissOnTouchOutside: false,
                        ).show(),
                      );
                },
        );
      },
    );
  }
}
