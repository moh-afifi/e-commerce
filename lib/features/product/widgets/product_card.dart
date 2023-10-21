import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/core/widgets/net_image.dart';
import 'package:wssal/features/favorites/providers/favorites_provider.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/product/screens/product_details_screen.dart';
import 'package:wssal/features/product/widgets/product_card_units.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key, required this.product, required this.showRemoveButton})
      : super(key: key);
  final bool showRemoveButton;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Ribbon(
          nearLength: product.hasDiscount ? 60 : 0,
          farLength: product.hasDiscount ? 30 : 0,
          title: 'عرض خاص',
          titleStyle: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          color: Colors.red,
          location: RibbonLocation.topStart,
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                  product: product,
                ),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffE2E2E2),
                ),
                borderRadius: BorderRadius.circular(
                  18,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      showRemoveButton
                          ? InkWell(
                              onTap: () => context
                                  .read<FavoriteProvider>()
                                  .removeFromFavorites(
                                      productId: product.id ?? ''),
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : _FavButton(product: product),
                    ],
                  ),
                  Hero(
                    tag: product.id ?? '',
                    child: NetImage(
                      product.image ?? '',
                      height: 70,
                      width: 70,
                    ),
                  ),
                  ProductCardUnits(product: product),
                  Text(
                    product.itemName ?? '',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  // addWidget()
                ],
              ),
            ),
          ),
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
    );
  }
}

class _FavButton extends StatelessWidget {
  const _FavButton({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteProvider>(
      builder: (context, provider, child) {
        bool isFav = product.isFavorite;
        if (provider.productList.isNotEmpty) {
          isFav =
              provider.productList.any((element) => element.id == product.id);
        } else {
          isFav = false;
        }
        return InkWell(
          onTap: () async {
            if (isFav) {
              await context
                  .read<FavoriteProvider>()
                  .removeFromFavorites(productId: product.id ?? '-1');
            } else {
              await context
                  .read<FavoriteProvider>()
                  .addToFavorites(productId: product.id ?? '-1');
            }
          },
          child: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
            size: 30,
          ),
        );
      },
    );
  }
}
