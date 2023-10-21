import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/counter_button.dart';
import 'package:wssal/core/widgets/net_image.dart';
import 'package:wssal/features/cart/data/models/cart_item_model.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 80,
            width: 50,
            child: NetImage(product.image ?? ''),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.itemName ?? '',
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.chosenUnit?.id ?? '',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: AppColors.secondColor,
                      ),
                    ),
                    _Price(
                      product: product,
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _QuantityCounter(
                      product: product,
                    ),
                    _RemoveCartItem(
                      product: product,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//---------------------------------------------------------------------
class _QuantityCounter extends StatefulWidget {
  const _QuantityCounter({Key? key, required this.product}) : super(key: key);
  final Product? product;

  @override
  State<_QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<_QuantityCounter> {
  int quantity = 1;

  bool get isAvailable => widget.product?.chosenUnit?.isAvailable ?? false;

  @override
  void initState() {
    if (isAvailable) {
      setState(() => quantity = widget.product?.chosenUnit?.quantity?.toInt() ?? 1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CartProvider>();
    return isAvailable
        ? Row(
            children: [
              CounterButton(
                icon: Icons.add,
                iconColor: Colors.teal,
                size: 22,
                iconSize: 15,
                onTap: () {
                  final double max = widget.product?.chosenUnit?.maxAmount ?? 0;
                  if (quantity < max) {
                    setState(() => quantity++);
                    provider.updateQuantity(
                      product: widget.product,
                      quantity: quantity.toDouble(),
                    );
                  } else {
                    AppUtils.showSnackBar(
                      context: context,
                      message:
                          "الحد الأقصى للطلب : ${max.toStringAsFixed(0)} وحدات",
                    );
                  }
                },
              ),
              const SizedBox(width: 18),
              Text(
                quantity.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 18),
              CounterButton(
                icon: Icons.remove,
                size: 22,
                iconSize: 15,
                iconColor: Colors.red,
                onTap: () {
                  if (quantity == 1) return;
                  setState(() => quantity--);
                  provider.updateQuantity(
                    product: widget.product,
                    quantity: quantity.toDouble(),
                  );
                },
              ),
            ],
          )
        : const Text(
            "غير متوفر",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: AppColors.thirdColor,
            ),
          );
  }
}

//---------------------------------------------------------------------
class _Price extends StatelessWidget {
  const _Price({Key? key, required this.product}) : super(key: key);
  final Product product;
  bool get isAvailable => product.chosenUnit?.isAvailable ?? false;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isAvailable,
      child: Selector<CartProvider, List<ItemModel>>(
        shouldRebuild: (previous, next) => previous != next,
        selector: (context, provider) => provider.itemsList,
        builder: (context, itemsList, _) {
          final double unitPrice = itemsList.singleWhere((element) => element.uniqueId == product.uniqueId).unitPrice ?? 0;
          final double qty = itemsList.singleWhere((element) => element.uniqueId == product.uniqueId).qty ?? 0;
          return Visibility(
            visible: unitPrice * qty != 0,
            child: Text(
              "${unitPrice * qty}" " جنيه ",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: AppColors.primaryColor,
              ),
            ),
          );
        },
      ),
    );
  }
}

//---------------------------------------------------------------------
class _RemoveCartItem extends StatelessWidget {
  const _RemoveCartItem({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.read<CartProvider>().removeFromCart(
          itemCode: product.id ?? '-1',
          unitId: product.chosenUnit?.id ?? '-1',
          uniqueId: product.uniqueId ?? '-1'),
      child: const Row(
        children: [
          Text(
            'حذف المنتج',
            style: TextStyle(fontSize: 10),
          ),
          SizedBox(width: 5),
          Icon(
            Icons.delete_forever_outlined,
            color: Colors.red,
            size: 18,
          ),
        ],
      ),
    );
  }
}
