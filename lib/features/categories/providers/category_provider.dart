import 'package:flutter/material.dart';
import 'package:wssal/features/categories/data/data_source/category_data_source.dart';
import 'package:wssal/features/categories/data/models/categories_model.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class CategoriesProvider extends ChangeNotifier {
  CategoriesProvider() {
    getCategories();
  }

  final CategoryDataSource _categoryDataSource = CategoryDataSource();
  List<Group> _groupsList = [];

  List<Group> get groupsList => _groupsList;

  List<Product> _productList = [];

  List<Product> get productList => _productList;

  bool _loading = false;

  bool get loading => _loading;
  String? _error;

  String? get error => _error;

  bool _loadingProducts = false;

  bool get loadingProducts => _loadingProducts;
  String? _errorProducts;

  String? get errorProducts => _errorProducts;

  void _toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void _toggleError(String? err) {
    _error = err;
    notifyListeners();
  }

  void _toggleLoadingProducts(bool val) {
    _loadingProducts = val;
    notifyListeners();
  }

  void _toggleErrorProducts(String? err) {
    _errorProducts = err;
    notifyListeners();
  }

  Future<void> getCategories() async {
    try {
      _toggleLoading(true);
      _toggleError(null);
      final response = await _categoryDataSource.getCategories();
      _groupsList = response?.groupsList ?? [];
      notifyListeners();
      _toggleLoading(false);
    } catch (e) {
      _toggleLoading(false);
      _toggleError(e.toString());
    }
  }

  String? selectedSubCategoryId;

  void changeSelectedId(String? id) {
    selectedSubCategoryId = id;
    notifyListeners();
  }

  Future<void> getCategoryProducts({required String categoryId,required String subCategoryId}) async {
    try {
      changeSelectedId(subCategoryId);
      _toggleLoadingProducts(true);
      _toggleErrorProducts(null);
      final response = await _categoryDataSource.getCategoryProducts(categoryId: categoryId, subCategoryId: subCategoryId);
      _productList.clear();
      _productList = response?.productList ?? [];
      notifyListeners();
      _toggleLoadingProducts(false);
    } catch (e) {
      _toggleLoadingProducts(false);
      _toggleErrorProducts(e.toString());
    }
  }

}
