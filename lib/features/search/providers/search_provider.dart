import 'package:flutter/material.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/search/data/data_source/search_data_source.dart';

class SearchProvider extends ChangeNotifier {
  final SearchDataSource _searchDataSource = SearchDataSource();
  final searchController = TextEditingController();
  List<Product> _productList = [];

  List<Product> get productList => _productList;

  bool _loading = false;

  bool get loading => _loading;

  String? _error;

  String? get error => _error;

  void _changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void _changeError(String? errorText) {
    _error = errorText;
    notifyListeners();
  }

  Future<void> searchProducts() async {
    try {
      _changeLoading(true);
      _changeError(null);
      final response = await _searchDataSource.searchProducts(
          searchWord: searchController.text);
      _productList = [];
      _productList = response?.productList ?? [];
      notifyListeners();
      _changeLoading(false);
    } catch (e) {
      _changeLoading(false);
      _changeError(e.toString());
    }
  }

  Future<Product?> scanProducts({required String barcode}) async {
    try {
      _changeLoading(true);
      _changeError(null);
      searchController.clear();
      final response = await _searchDataSource.scanProducts(barcode: barcode);
      _productList = [];
      _productList = response?.productList ?? [];
      notifyListeners();
      _changeLoading(false);
      if (_productList.isNotEmpty) {
        return _productList.first;
      }
      return null;
    } catch (e) {
      _changeLoading(false);
      _changeError(e.toString());
      return null;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
