import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/favorites/providers/favorites_provider.dart';
import 'package:wssal/features/product/widgets/product_card.dart';
class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "المفضلة",
        showBackButton: false,
      ),
      body: Consumer<FavoriteProvider>(
        builder: (_, provider, __) {
          if (provider.loading) return const AppLoader();
          if (provider.error != null) return const ErrorView();
          return provider.productList.isEmpty
              ? const EmptyView()
              : GridView.builder(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                padding: const EdgeInsets.all(15),
                itemCount: provider.productList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(
                    product: provider.productList[index],
                    showRemoveButton: true,
                  );
                },
              );
        },
      ),
    );
  }
}
