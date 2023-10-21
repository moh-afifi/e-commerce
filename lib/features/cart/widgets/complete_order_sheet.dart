import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/constants/constants.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/address/providers/address_provider.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/cart/widgets/choose_address.dart';
import 'package:wssal/features/cart/widgets/confirm_order_button.dart';

import 'choose_deliver_date.dart';
import 'choose_delivery_time.dart';
import 'notes_text_field.dart';

class CompleteOrderSheet extends StatefulWidget {
  const CompleteOrderSheet({Key? key}) : super(key: key);

  @override
  State<CompleteOrderSheet> createState() => _CompleteOrderSheetState();
}

class _CompleteOrderSheetState extends State<CompleteOrderSheet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CartProvider>().resetData();
      await context.read<AddressProvider>().getAddresses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  'متابعة الطلب',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ChooseDeliverDate(),

            ChooseDeliveryTime(),
            Divider(),
            NotesTextField(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'اختر عنوان الاستلام',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  _AddAddressButton(),
                ],
              ),
            ),
            ChooseAddress(),
            ConfirmOrderButton()
          ],
        ),
      ),
    );
  }
}

class _AddAddressButton extends StatelessWidget {
  const _AddAddressButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddressProvider>();
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider.value(
              value: provider,
              child: GlobalScaffold(
                body: PlacePicker(
                  apiKey: Constants.mapKey,
                  onPlacePicked: (result) async {
                    provider.pickMapAddress(result);
                    Navigator.of(context).pop();
                    await provider.addAddress().then((res) {
                      if (res != null) {
                        AppUtils.showSnackBar(context: context, message: res);
                      }
                    });
                  },
                  hintText: "بحث..",
                  selectText: 'تأكيد',
                  selectInitialPosition: true,
                  initialPosition: const LatLng(20, 30),
                  useCurrentLocation: true,
                  autocompleteLanguage: 'ar',
                  region: 'eg',
                  resizeToAvoidBottomInset: false,
                ),
              ),
            ),
          ),
        );
      },
      child: const Text(
        'إضافة عنوان',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.thirdColor,
          decoration: TextDecoration.underline,
          fontSize: 12,
        ),
      ),
    );
  }
}
