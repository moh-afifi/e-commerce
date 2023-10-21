import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/features/favorites/providers/favorites_provider.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class FavoriteToggleIcon extends StatelessWidget {
  const FavoriteToggleIcon({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final favProvider = context.read<FavoriteProvider>();
    return Selector<FavoriteProvider, List<Product>>(
      shouldRebuild: (previous, next) => true,
      selector: (context, provider) => provider.productList,
      builder: (context, productList, _) {
        bool isFav = false;
        if (favProvider.productList.isNotEmpty) {
          isFav = favProvider.productList.any((element) => element.id == productId);
        } else {
          isFav = false;
        }
        return InkWell(
          onTap: () async{
            if (isFav) {
              await favProvider.removeFromFavorites(productId: productId);
            } else {
              await favProvider.addToFavorites(productId: productId);
            }
          },
          child: Icon(
            isFav ? Icons.favorite : Icons.favorite_border,
            color: isFav ? Colors.red : Colors.blueGrey,
            size: 35,
          ),
        );
      },
    );
  }
}
