import 'package:flutter/material.dart';
import 'package:wssal/features/best_seller/data/data_source/best_seller_data_source.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class BestSellerProvider extends ChangeNotifier {
  final BestSellerDataSource _bestSellerDataSource = BestSellerDataSource();

  List<Product> _bestSellerList = [];

  List<Product> get bestSellerList => _bestSellerList;

  bool _loading = false;

  bool get loading => _loading;
  String? _error;

  String? get error => _error;

  void _toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void _toggleError(String? err) {
    _error = err;
    notifyListeners();
  }

  Future<void> getBestSellerProducts() async {
    try {
      _toggleLoading(true);
      _toggleError(null);
      final response = await _bestSellerDataSource.getBestSellerProducts();
      _bestSellerList = response?.productList ?? [];
      notifyListeners();
      _toggleLoading(false);
    } catch (e) {
      _toggleLoading(false);
      _toggleError(e.toString());
    }
  }
}
