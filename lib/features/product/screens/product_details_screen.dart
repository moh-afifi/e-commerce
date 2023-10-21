import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/favorites/providers/favorites_provider.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/product/providers/product_provider.dart';
import 'package:wssal/features/product/widgets/add_to_cart_button.dart';
import 'package:wssal/features/product/widgets/cart_summary.dart';
import 'package:wssal/features/product/widgets/product_description.dart';
import 'package:wssal/features/product/widgets/product_screen_header.dart';
import 'package:wssal/features/product/widgets/units_drop_down.dart';

import '../../../core/widgets/global_bottom_bar.dart';
import '../widgets/favourite_toggle_icon.dart';
import '../widgets/product_counter.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    final bool hasProductInCart = cartProvider.itemsList.any((p) => p.itemCode == product.id);
    String? cartUnitId;
    if (hasProductInCart) {
      cartUnitId = cartProvider.itemsList.singleWhere((p) => p.itemCode == product.id).uom;
    }
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(
        product: product,
        isInCart: hasProductInCart,
        cartUnitId: cartUnitId,
      ),
      child: _ProductDetailsContent(product: product),
    );
  }
}

class _ProductDetailsContent extends StatelessWidget {
  const _ProductDetailsContent({Key? key, required this.product})
      : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                ProductScreenHeader(
                  imagePath: product.image ?? '',
                  productId: product.id ?? '',
                ),
                const Divider(thickness: 1, height: 1),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              product.itemName ?? '',
                              style: const TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                              ),
                              maxLines: 3,
                            ),
                          ),
                          FavoriteToggleIcon(productId: product.id ?? ''),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          ProductCounter(product: product),
                          const Spacer(),
                          Selector<ProductProvider, double>(
                            shouldRebuild: (previous, next) => true,
                            selector: (context, provider) => provider.price,
                            builder: (context, price, _) {
                              final p = context.read<ProductProvider>();
                              final pr = p.unitPrice * p.amount;
                              return Visibility(
                                visible: price != 0,
                                child: Text(
                                  "${pr.toString()}" " جنيه ",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProductDescription(
                        description: product.description,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const UnitsDropDown(),
                    ],
                  ),
                ),
                const CartSummary(),
                AddToCartButton(product: product),
              ],
            ),
            Selector<FavoriteProvider, String?>(
              shouldRebuild: (previous, next) => previous != next,
              selector: (context, provider) => provider.productId,
              builder: (context, productId, _) {
                return Visibility(
                  visible: productId == product.id,
                  child: const AppLoader(),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const GlobalBottomBar(
        currentIndex: -1,
        popToRoot: true,
      ),
    );
  }
}
