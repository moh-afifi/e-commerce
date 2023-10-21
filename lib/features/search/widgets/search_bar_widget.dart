import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/plain_text_field.dart';
import 'package:wssal/features/product/screens/product_details_screen.dart';
import 'package:wssal/features/search/providers/search_provider.dart';
// ignore_for_file: use_build_context_synchronously

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: PlainTextField(
        hintText: "ابحث عن منتجات..",
        errorText: 'برجاء ادخال كلمة البحث',
        hintColor: Colors.grey,
        suffix: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
          mainAxisSize: MainAxisSize.min, // added line
          children: [
            InkWell(
              onTap: () => _scanBarCode(context),
              child: const Icon(
                FontAwesomeIcons.barcode,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(width: 15),
            InkWell(
              onTap: () => _search(context),
              child: const Icon(
                Icons.search,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        onEditingComplete: () => _search(context),
        controller: context.read<SearchProvider>().searchController,
      ),
    );
  }

  _search(BuildContext context) {
    final searchProvider = context.read<SearchProvider>();
    FocusScope.of(context).requestFocus(FocusNode());
    if (searchProvider.searchController.text.trim().isNotEmpty) {
      searchProvider.searchProducts();
    }
  }

  _scanBarCode(BuildContext context) async {

    FocusScope.of(context).requestFocus(FocusNode());
    try {
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "إلغاء",
        true,
        ScanMode.BARCODE,
      );
      if (barcodeScanRes != '-1') {
        context.read<SearchProvider>()
            .scanProducts(barcode: barcodeScanRes)
            .then(
          (product) {
            if (product != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: product,
                  ),
                ),
              );
            }
          },
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
