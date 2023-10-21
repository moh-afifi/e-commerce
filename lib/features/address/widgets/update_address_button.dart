import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/constants/constants.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/address/providers/address_provider.dart';
//ignore_for_file: use_build_context_synchronously
class UpdateAddressButton extends StatelessWidget {
  const UpdateAddressButton({Key? key, required this.addressId})
      : super(key: key);
  final String addressId;

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AddressProvider>();
    return InkWell(
      onTap: () async {
        if (await Geolocator.isLocationServiceEnabled()) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: provider,
                child:  GlobalScaffold(
                  body: PlacePicker(
                    apiKey: Constants.mapKey,
                    onPlacePicked: (result) async {
                      provider.pickMapAddress(result);
                      Navigator.of(context).pop();
                      await provider
                          .updateAddress(addressId: addressId)
                          .then((res) {
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
        } else {
          AppUtils.showSnackBar(
              context: context, message: "الرجاء تفعيل خدمة الموقع");
        }
      },
      child: const Text(
        'تعديل',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          decoration: TextDecoration.underline,
          color: Colors.orange,
        ),
      ),
    );
  }
}
