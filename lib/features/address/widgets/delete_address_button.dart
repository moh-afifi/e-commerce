import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/features/address/providers/address_provider.dart';

class DeleteAddressButton extends StatelessWidget {
  const DeleteAddressButton({Key? key, required this.addressId})
      : super(key: key);
  final String addressId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.question,
          desc: 'هل تريد حذف العنوان؟',
          btnCancelOnPress: () {},
          btnCancelText: 'إلغاء',
          btnOkOnPress: () => context.read<AddressProvider>().deleteAddress(addressId: addressId),
          btnOkText: 'موافق',
        ).show();
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          'حذف',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            decoration: TextDecoration.underline,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
