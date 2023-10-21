import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/orders/providers/orders_provider.dart';
import 'package:wssal/features/orders/widgets/order_card.dart';

class ExpiredOrders extends StatelessWidget {
  const ExpiredOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersProvider>(
      builder: (_, provider, __) {
        if (provider.loading) return const AppLoader();
        if (provider.error != null) return const ErrorView();
        final expiredOrdersList = provider.expiredOrdersList;
        return expiredOrdersList.isEmpty
            ? const EmptyView()
            : ModalProgressHUD(
                inAsyncCall: provider.actionLoading,
                progressIndicator: const AppLoader(),
                child: ListView.builder(
                  itemCount: expiredOrdersList.length,
                  itemBuilder: (context, index) {
                    return OrderCard(
                      invoice: expiredOrdersList[index],
                    );
                  },
                ),
              );
      },
    );
  }
}
