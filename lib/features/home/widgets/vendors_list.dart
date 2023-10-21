import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/vendors/providers/vendors_provider.dart';
import 'package:wssal/features/vendors/widgets/vendor_card.dart';

class VendorsList extends StatelessWidget {
  const VendorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Consumer<VendorProvider>(
        builder: (_, provider, __) {
          if (provider.loading) return const AppLoader();
          if (provider.error != null) return const ErrorView();
          final vendorsList = provider.vendorsList;
          return vendorsList.isEmpty
              ? const EmptyView()
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: vendorsList.length,
                  itemBuilder: (context, index) {
                    return VendorCard(
                      vendor: vendorsList[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                );
        },
      ),
    );
  }
}
