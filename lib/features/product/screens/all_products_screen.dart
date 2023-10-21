import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/offers/providers/offers_provider.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/product/data/models/product_type_enum.dart';
import 'package:wssal/features/product/widgets/product_card.dart';
import 'package:wssal/features/vendors/providers/vendors_provider.dart';

class AllProductsScreens extends StatefulWidget {
  const AllProductsScreens({
    Key? key,
    required this.productType,
    this.offerId,
    this.vendorId,
  }) : super(key: key);
  final ProductTypeEnum productType;
  final String? offerId;
  final String? vendorId;

  @override
  State<AllProductsScreens> createState() => _AllProductsScreensState();
}

class _AllProductsScreensState extends State<AllProductsScreens> {
  late final Future<List<Product>>? _future;

  Future<List<Product>>? getFuture(ProductTypeEnum productType) {
    if (productType == ProductTypeEnum.offer) {
      return context
          .read<OffersProvider>()
          .getOffersProducts(offerId: widget.offerId ?? '-1');
    } else if (productType == ProductTypeEnum.vendor) {
      return context.read<VendorProvider>().getVendorProducts(vendorId: widget.vendorId ?? '-1');
    } else {
      return Future.value([]);
    }
  }

  @override
  void initState() {
    _future = getFuture(widget.productType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "المنتجات",
        showBackButton: true,
      ),
      body: AsyncBuilder<List<Product>>(
        future: _future,
        waiting: (context) => const AppLoader(),
        error: (context, error, stackTrace) =>
            ErrorView(error: error.toString()),
        builder: (context, data) {
          final productList = data ?? [];
          return productList.isEmpty
              ? const EmptyView()
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 0.65,
                  ),
                  padding: const EdgeInsets.all(15),
                  itemCount: productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(
                      product: productList[index],
                      showRemoveButton: false,
                    );
                  },
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
