import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/cart/widgets/cart_item.dart';
import 'package:wssal/features/cart/widgets/complete_order_sheet.dart';
import 'package:wssal/features/root/providers/root_provider.dart';

import '../../../core/widgets/app_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "السلة",
        showBackButton: false,
      ),
      body: Consumer<CartProvider>(
        builder: (_, provider, __) {
          if (provider.loading) return const AppLoader();
          if (provider.error != null) return const ErrorView();
          return provider.productList.isEmpty
              ? const EmptyView()
              : Column(
                  children: [
                    Expanded(
                      child: ModalProgressHUD(
                        inAsyncCall: provider.actionLoading,
                        progressIndicator: const AppLoader(),
                        child: ListView.separated(
                          itemCount: provider.productList.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(thickness: 1),
                          itemBuilder: (BuildContext context, int index) {
                            return CartItem(
                              product: provider.productList[index],
                            );
                          },
                        ),
                      ),
                    ),
                    const _TotalPrice(),
                    const _CreateOrderButton(),
                  ],
                );
        },
      ),
    );
  }
}

class _TotalPrice extends StatelessWidget {
  const _TotalPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, double>(
      shouldRebuild: (previous, next) => true,
      selector: (context, provider) => provider.totalPrice,
      builder: (context, totalPrice, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "الإجمالي:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "$totalPrice" " جنيه ",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CreateOrderButton extends StatelessWidget {
  const _CreateOrderButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: AppButton(
        label: 'متابعة الطلب',
        isBusy: false,
        fontWeight: FontWeight.w600,
        padding: const EdgeInsets.symmetric(vertical: 10),
        onPressed: () {
          final minAmount = context.read<RootProvider>().appSateModel?.minPrice ?? 0;
          final totalCartPrice = context.read<CartProvider>().totalPrice;
          if (totalCartPrice < minAmount) {
            AwesomeDialog(
              context: context,
              animType: AnimType.scale,
              dialogType: DialogType.warning,
              desc: 'الحد الأدنى للطلب $minAmount جنيه ',
              btnOkOnPress: () {},
              btnOkText: 'موافق',
            ).show();
          } else if (context
              .read<CartProvider>()
              .itemsList
              .any((unit) => unit.maxQuantity != 0)) {
            showMaterialModalBottomSheet(
              context: context,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              enableDrag: true,
              builder: (_) => const CompleteOrderSheet(),
            );
          } else {
            AppUtils.showSnackBar(
                context: context, message: 'المنتجات في السلة غير متوفرة');
          }
        },
      ),
    );
  }
}
