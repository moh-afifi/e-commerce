import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/product/providers/product_provider.dart';
import 'package:wssal/features/root/providers/root_provider.dart';

class CartSummary extends StatelessWidget {
  const CartSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, provider, __) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'إجمالي السلة',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "${provider.totalPrice.toStringAsFixed(1)}" " جنيه ",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'إجمالي طلبك',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Selector<ProductProvider, double>(
                    shouldRebuild: (previous, next) => previous != next,
                    selector: (context, provider) => provider.price,
                    builder: (context, price, _) {
                      final cartTotal = provider.totalPrice;
                      final total = cartTotal + price;
                      return Text(
                        "${total.toStringAsFixed(1)}" " جنيه ",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      );
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'الحد الأدنى للطلب',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '${context.read<RootProvider>().appSateModel?.minPrice.toStringAsFixed(0) ?? 0}'
                    " جنيه ",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
