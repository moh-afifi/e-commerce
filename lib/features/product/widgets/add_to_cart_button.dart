import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/app_button.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/product/providers/product_provider.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({Key? key, required this.product}) : super(key: key);
  final Product product;

  void _addToCart(BuildContext context, ProductProvider productProvider) {
    context
        .read<CartProvider>()
        .addToCart(
          itemCode: product.id ?? '-1',
          itemUnit: productProvider.productUnit?.id ?? '-1',
          itemQuantity: productProvider.amount,
        )
        .then(
      (error) {
        final success = error == null;
        return AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: success ? DialogType.success : DialogType.error,
          body: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              error ?? 'تم اضافة المنتج الى السلة بنجاح',
              style: const TextStyle(fontSize: 12),
            ),
          ),
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          btnOkOnPress: () {
            if (success) Navigator.pop(context);
          },
          btnOkText: 'موافق',
        ).show();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    final cartProvider = context.read<CartProvider>();
    return Selector<CartProvider, bool>(
      shouldRebuild: (previous, next) => previous != next,
      selector: (context, provider) => provider.actionLoading,
      builder: (context, loading, _) {
        return AppButton(
          label: "إضافة إلى السلة",
          isBusy: loading,
          margin:const EdgeInsets.only(left: 15,right: 15,bottom: 10),
          onPressed: productProvider.productAvailable
              ? () {
                  var maxAmount = productProvider.productUnit?.maxAmount ?? 0;
                  final isProductInCart = cartProvider.itemsList.any(
                      (element) =>
                          element.itemCode == product.id &&
                          element.uom == productProvider.productUnit?.id);
                  final productQuantity = productProvider.amount;
                  if (isProductInCart) {
                    var cartQuantity = cartProvider.itemsList
                            .singleWhere((element) =>
                                element.itemCode == product.id &&
                                element.uom == productProvider.productUnit?.id)
                            .qty ??
                        0;
                    if (cartQuantity == maxAmount) {
                      AppUtils.showSnackBar(
                          context: context,
                          message: "لا يوجد رصيد مخزون للمنتج");
                    } else if (cartQuantity < maxAmount) {
                      final max = maxAmount - cartQuantity;
                      if (productQuantity <= max) {
                        _addToCart(context, productProvider);
                      } else {
                        AppUtils.showSnackBar(
                            context: context,
                            message:
                                "الحد الأقصى للطلب ${max.toStringAsFixed(0)} وحدة");
                      }
                    }
                  } else {
                    _addToCart(context, productProvider);
                  }
                }
              : null,
        );
      },
    );
  }
}
