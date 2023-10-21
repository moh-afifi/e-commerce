import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/counter_button.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/product/providers/product_provider.dart';

class ProductCounter extends StatelessWidget {
  const ProductCounter({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    return Visibility(
      visible: productProvider.productAvailable,
      child: Selector<ProductProvider, int>(
        shouldRebuild: (previous, next) => previous != next,
        selector: (context, provider) => provider.amount,
        builder: (context, amount, _) {
          return Row(
            children: [
              CounterButton(
                icon: Icons.add,
                iconColor: Colors.teal,
                onTap: () {
                  productProvider.increaseAmount();

                  // var maxAmount = productProvider.productUnit?.maxAmount ?? 0;
                  //
                  // final isProductInCart = cartProvider.itemsList.any((element) => element.itemCode == product.id && element.uom == productProvider.productUnit?.id);
                  // final productQuantity = productProvider.amount;
                  // if (isProductInCart) {
                  //   var cartQuantity = cartProvider.itemsList.singleWhere((element) => element.itemCode == product.id && element.uom == productProvider.productUnit?.id).qty ?? 0;
                  //   if (cartQuantity == maxAmount) {
                  //     AppUtils.showSnackBar(context: context, message: "لا يوجد رصيد مخزون للمنتج");
                  //   } else if (cartQuantity < maxAmount) {
                  //     final max = maxAmount - cartQuantity;
                  //     if (productQuantity < max) {
                  //       productProvider.increaseAmount();
                  //     } else {
                  //       print('$maxAmount **********');
                  //       AppUtils.showSnackBar(context: context, message: "الحد الأقصى للطلب ${max.toStringAsFixed(0)} وحدة");
                  //     }
                  //   }
                  // } else {
                  //   if (amount < maxAmount) {
                  //     productProvider.increaseAmount();
                  //   } else {
                  //     AppUtils.showSnackBar(
                  //       context: context,
                  //       message: "الحد الأقصى للطلب : ${maxAmount.toStringAsFixed(0)} وحدات",
                  //     );
                  //   }
                  //
                  // }
                },
              ),
              const SizedBox(width: 18),
              Text(
                amount.toString(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 18),
              CounterButton(
                icon: Icons.remove,
                iconColor: Colors.red,
                onTap: () => productProvider.decreaseAmount(),
              ),
            ],
          );
        },
      ),
    );
  }
}
