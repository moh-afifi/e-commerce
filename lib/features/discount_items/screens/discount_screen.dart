import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/discount_items/providers/discount_provider.dart';
import 'package:wssal/features/product/widgets/product_card.dart';

import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading.dart';
import '../../product/data/models/product_model.dart';

class DiscountScreen extends StatelessWidget {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DiscountProvider(),
      child: const _DiscountScreenContent(),
    );
  }
}

class _DiscountScreenContent extends StatelessWidget {
  const _DiscountScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "العروض",
        showBackButton: false,
      ),
      body: AsyncBuilder<List<Product>>(
        future: context.read<DiscountProvider>().getDiscountProducts(),
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
    );
  }
}
