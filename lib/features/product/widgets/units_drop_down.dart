import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/product/providers/product_provider.dart';

class UnitsDropDown extends StatelessWidget {
  const UnitsDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productProvider = context.read<ProductProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'اختر الوحدة:',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        Selector<ProductProvider, ProductUnit?>(
          shouldRebuild: (previous, next) => previous != next,
          selector: (context, provider) => provider.productUnit,
          builder: (context, productUnit, _) {
            return Container(
              width: 200,
              height: 35,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
              ),
              child: DropdownButton<ProductUnit?>(
                isExpanded: true,
                underline: const SizedBox.shrink(),
                icon: const Icon(Icons.keyboard_arrow_down),
                hint: const Text("غير متوفر"),
                iconSize: 24,
                elevation: 16,
                value: productUnit,
                onChanged: (unit) => productProvider.chooseProductUnit(unit),
                dropdownColor: Colors.white,
                items: productProvider.unitsList
                    .map<DropdownMenuItem<ProductUnit?>>(
                  (ProductUnit? value) {
                    return DropdownMenuItem<ProductUnit?>(
                      value: value,
                      child: Text(
                        value?.name ?? '',
                        style: const TextStyle(
                          color: Color(0xffFE9243),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
