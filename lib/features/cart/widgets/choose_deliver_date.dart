import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';

class ChooseDeliverDate extends StatelessWidget {
  const ChooseDeliverDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            final date = await AppUtils.selectDate(context);
            if (date != null) {
              cartProvider.changeDeliveryDate(date);
            }
          },
          child: const Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: AppColors.secondColor,
              ),
              SizedBox(width: 10),
              Text(
                'اختر تاريخ الاستلام',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ),
        Selector<CartProvider, DateTime?>(
          shouldRebuild: (previous, next) => previous != next,
          selector: (context, provider) => provider.deliveryDate,
          builder: (context, deliveryDate, _) {
            return Visibility(
              visible: deliveryDate != null,
              child: Text(
                deliveryDate == null
                    ? ""
                    : '${deliveryDate.day}/${deliveryDate.month}/${deliveryDate.year}',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.thirdColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
