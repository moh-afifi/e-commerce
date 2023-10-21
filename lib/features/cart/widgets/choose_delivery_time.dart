import 'package:async_builder/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/cart/data/models/delivery_time.dart';

import '../../../core/widgets/empty_view.dart';
import '../../../core/widgets/error_view.dart';
import '../../../core/widgets/loading.dart';
import '../providers/cart_provider.dart';

class ChooseDeliveryTime extends StatelessWidget {
  const ChooseDeliveryTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncBuilder<List<DeliveryTime>>(
      future: context.read<CartProvider>().getDeliveryTimes(),
      waiting: (context) => const AppLoader(),
      error: (context, error, stackTrace) =>
          ErrorView(error: error.toString()),
      builder: (context, data) {
        final deliveryTimesList = data ?? [];
        return deliveryTimesList.isEmpty
            ? const EmptyView()
            : Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Row(
                children: [
                  Icon(
                    Icons.access_time_outlined,
                    color: AppColors.secondColor,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'اختر وقت الاستلام',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Wrap(
                children: List.generate(
                  deliveryTimesList.length,
                      (index) => TimeCard(
                    deliveryTime: deliveryTimesList[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TimeCard extends StatelessWidget {
  const TimeCard({Key? key, required this.deliveryTime}) : super(key: key);
  final DeliveryTime deliveryTime;

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, String?>(
      shouldRebuild: (previous, next) => previous != next,
      selector: (context, provider) => provider.selectedTimeId,
      builder: (context, selectedTimeId, _) {
        return InkWell(
          onTap: () => context
              .read<CartProvider>()
              .changeSelectedTime(deliveryTime.title),
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: selectedTimeId == deliveryTime.title
                    ? AppColors.thirdColor
                    : Colors.white,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: Text(
                "${deliveryTime.fromTime} - ${deliveryTime.toTime} ${deliveryTime.title}",
                style: const TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
