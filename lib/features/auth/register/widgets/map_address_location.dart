import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/constants/constants.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/text_field_label.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';
//ignore_for_file: use_build_context_synchronously

class MapAddressSelection extends StatelessWidget {
  const MapAddressSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const TextFieldLabel(
                label: 'العنوان على الخريطة',
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  if (await Geolocator.isLocationServiceEnabled()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider.value(
                          value: context.read<RegisterProvider>(),
                          child:  GlobalScaffold(
                            body: PlacePicker(
                              apiKey: Constants.mapKey,
                              onPlacePicked: (result) {
                                context
                                    .read<RegisterProvider>()
                                    .changeMapAddress(result);
                                Navigator.of(context).pop();
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
                  "افتح الخريطة",
                  style: TextStyle(
                      color: AppColors.thirdColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              ),
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.thirdColor,
                size: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Selector<RegisterProvider, String?>(
            shouldRebuild: (previous, next) => previous != next,
            selector: (context, provider) =>
                provider.pickResult?.formattedAddress,
            builder: (context, mapAddress, _) {
              return Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
                child: Text(
                  mapAddress ?? 'العنوان على الخريطة',
                  style: TextStyle(
                    color: mapAddress == null ? Colors.grey : Colors.black,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
