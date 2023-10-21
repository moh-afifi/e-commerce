import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/vendors/providers/vendors_provider.dart';
import 'package:wssal/features/vendors/widgets/vendor_card.dart';

class MoreVendorsScreens extends StatelessWidget {
  const MoreVendorsScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vendorsList = context.read<VendorProvider>().vendorsList;
    return GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "شركائنا",
        showBackButton: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        itemCount: vendorsList.length,
        itemBuilder: (BuildContext context, int index) {
          return VendorCard(
            vendor: vendorsList[index],
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
