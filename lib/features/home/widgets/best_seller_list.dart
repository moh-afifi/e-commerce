import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/best_seller/providers/best_seller_provider.dart';
import 'package:wssal/features/product/widgets/product_card.dart';

class BestSellerList extends StatefulWidget {
  const BestSellerList({Key? key}) : super(key: key);

  @override
  State<BestSellerList> createState() => _BestSellerListState();
}

class _BestSellerListState extends State<BestSellerList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
            (_) => context.read<BestSellerProvider>().getBestSellerProducts());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<BestSellerProvider>(
      builder: (_, provider, __) {
        if (provider.loading) return const AppLoader();
        if (provider.error != null) return const ErrorView();
        final bestSellerList = provider.bestSellerList;
        return bestSellerList.isEmpty
            ? const EmptyView()
            : SizedBox(
                height: 240,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: bestSellerList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 180,
                      child: ProductCard(
                        product: bestSellerList[index],
                        showRemoveButton: false,
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                ),
              );
      },
    );
  }
}
