import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/best_seller/providers/best_seller_provider.dart';
import 'package:wssal/features/product/widgets/product_card.dart';

class MoreBestSellerScreen extends StatelessWidget {
  const MoreBestSellerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productList = context.read<BestSellerProvider>().bestSellerList;
    return GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "الأكثر مبيعاً",
        showBackButton: true,
      ),
      body: productList.isEmpty
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
            ),
      bottomNavigationBar: const GlobalBottomBar(
        currentIndex: -1,
        popToRoot: true,
      ),
    );
  }
}
