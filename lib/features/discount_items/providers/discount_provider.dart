import 'package:flutter/material.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

import '../data/data_source/discount_data_source.dart';

class DiscountProvider extends ChangeNotifier {
  final DiscountDataSource _discountDataSource = DiscountDataSource();

  Future<List<Product>> getDiscountProducts() async {
    final response = await _discountDataSource.getDiscountProducts();
    return response?.productList ?? [];
  }
}
