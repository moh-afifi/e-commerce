import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/features/orders/data/models/invoice_details.dart';
import 'package:wssal/features/orders/providers/orders_provider.dart';

import '../../../core/utils/color_utils.dart';
import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/global_scaffold.dart';
import '../../../core/widgets/loading.dart';
import '../../../core/widgets/net_image.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({Key? key, required this.invoiceId})
      : super(key: key);
  final String invoiceId;

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBar: const GlobalAppBar(
        title: 'تفاصيل الفاتورة',
        showBackButton: true,
      ),
      body: AsyncBuilder<List<Item>>(
        future: context
            .read<OrdersProvider>()
            .getInvoiceDetails(invoiceId: invoiceId),
        waiting: (context) => const AppLoader(),
        error: (context, error, stackTrace) =>
            ErrorView(error: error.toString()),
        builder: (context, data) {
          final itemsList = data ?? [];
          return itemsList.isEmpty
              ? const EmptyView()
              : ListView.separated(
                  itemCount: itemsList.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(thickness: 1),
                  itemBuilder: (BuildContext context, int index) {
                    return _ItemCard(
                      item: itemsList[index],
                    );
                  },
                );
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  const _ItemCard({Key? key, required this.item}) : super(key: key);
  final Item item;

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
            child: NetImage('https://erp.wssaleg.com${item.image ?? ''}'),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemName ?? '',
                  maxLines: 3,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.uom ?? '',
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: AppColors.secondColor,
                      ),
                    ),
                    Text(
                      "الكمية:"" ${item.qty} " "وحدات",
                      maxLines: 3,
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "سعر الوحدة:" " ${item.rate} " " جنيه ",
                      style: const TextStyle(
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      "الإجمالي:" " ${item.amount} " " جنيه ",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
