import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/address/providers/address_provider.dart';
import 'package:wssal/features/address/widgets/add_address_button.dart';
import 'package:wssal/features/address/widgets/address_card.dart';
class AddressesScreen extends StatefulWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<AddressProvider>().getAddresses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "العناوين",
        actions: [AddAddressButton()],
      ),
      body: Consumer<AddressProvider>(
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
                    itemCount: addressList.length,
                    itemBuilder: (context, index) {
                      return AddressCard(
                        address: addressList[index],
                      );
                    },
                  ),
                );
        },
      ),
      bottomNavigationBar: const GlobalBottomBar(
        currentIndex: -1,
        popToRoot: true,
      ),
    );
  }
}
