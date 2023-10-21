import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/address/providers/address_provider.dart';
import 'package:wssal/features/address/widgets/address_card.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';

class ChooseAddress extends StatelessWidget {
  const ChooseAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    return Expanded(
      child: Consumer<AddressProvider>(
        builder: (_, provider, __) {
          if (provider.loading) return const AppLoader();
          if (provider.error != null) return const ErrorView();
          final addressList = provider.addressList;
          return addressList.isEmpty
              ? const EmptyView()
              : ModalProgressHUD(
                  inAsyncCall: provider.actionLoading,
                  progressIndicator: const AppLoader(),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: addressList.length,
                    itemBuilder: (context, index) {
                      return AddressCard(
                        horizontalMargin: 5,
                        address: addressList[index],
                        showSelection: true,
                        onSelectAddress: () =>
                            cartProvider.changeAddressId(addressList[index].id),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
