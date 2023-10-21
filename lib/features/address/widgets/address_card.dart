import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/features/address/data/models/address_model.dart';
import 'package:wssal/features/address/widgets/delete_address_button.dart';
import 'package:wssal/features/address/widgets/update_address_button.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    Key? key,
    required this.address,
    this.showSelection = false,
    this.onSelectAddress,
    this.horizontalMargin=15,
  }) : super(key: key);
  final Address address;
  final bool showSelection;
  final double horizontalMargin;
  final void Function()? onSelectAddress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectAddress,
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin:  EdgeInsets.symmetric(horizontal: horizontalMargin, vertical: 7),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'العنوان:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  showSelection
                      ? Selector<CartProvider, String?>(
                          shouldRebuild: (previous, next) => previous != next,
                          selector: (context, provider) =>
                              provider.selectedAddressId,
                          builder: (context, selectedAddressId, _) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              width: 25,
                              height: 25,
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selectedAddressId == address.id
                                      ? Colors.teal
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            );
                          },
                        )
                      : Row(
                          children: [
                            UpdateAddressButton(addressId: address.id ?? '-1'),
                            DeleteAddressButton(addressId: address.id ?? '-1'),
                          ],
                        )
                ],
              ),
              const SizedBox(height: 10),
              Text(address.address ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
