import 'package:flutter/material.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/utils/color_utils.dart';

import '../data/data_source/favorites_data_source.dart';
import '../data/models/product_model.dart';

class ProductCardUnits extends StatefulWidget {
  const ProductCardUnits({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<ProductCardUnits> createState() => _ProductCardUnitsState();
}

class _ProductCardUnitsState extends State<ProductCardUnits> {
  ProductUnit? selectedUnit;

  @override
  void initState() {
    if (widget.product.productUnitsList.isNotEmpty) {
      setState(() => selectedUnit = widget.product.productUnitsList.first);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.product.productUnitsList.isNotEmpty
        ? Column(
            children: [
              Text(
                "${selectedUnit?.price.toString()}" " جنيه ",
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: 150,
                height: 30,
                margin: const EdgeInsets.symmetric(vertical: 10),
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
                  hint: const Text(
                    "غير متوفر",
                    style: TextStyle(fontSize: 12),
                  ),
                  iconSize: 24,
                  elevation: 16,
                  value: selectedUnit,
                  onChanged: (unit) => setState(() => selectedUnit = unit),
                  dropdownColor: Colors.white,
                  items: widget.product.productUnitsList
                      .map<DropdownMenuItem<ProductUnit?>>(
                    (ProductUnit? value) {
                      return DropdownMenuItem<ProductUnit?>(
                        value: value,
                        child: Text(
                          value?.name ?? '',
                          style: const TextStyle(
                            color: Color(0xffFE9243),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          )
        : _NotAvailable(
            productId: widget.product.id ?? '',
          );
  }
}

class _NotAvailable extends StatelessWidget {
  const _NotAvailable({Key? key, required this.productId}) : super(key: key);
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "غير متوفر",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 5),
        InkWell(
          onTap: () {
            ProductDataSource().monitorProduct(productId: productId);
            AppUtils.showSnackBar(context: context, message: "سوف يتم إرسال إشعار عند توفر الطلب",isFailure: false);
          },
          child: const Text(
            "اضغط لتلقي اشعار عند توفره",
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: AppColors.primaryColor,
            ),
          ),
        )
      ],
    );
  }
}
