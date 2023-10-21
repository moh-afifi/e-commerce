import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wssal/features/favorites/data/data_source/favorites_data_source.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class FavoriteProvider extends ChangeNotifier {
  FavoriteProvider() {
    getFavorites();
  }

  final FavoritesDataSource _favoritesDataSource = FavoritesDataSource();
  bool _loading = false;

  bool get loading => _loading;
  final List<Product> _productList = [];

  List<Product> get productList => _productList;
  String? _error;

  String? get error => _error;


  String? _productId;

  String? get productId => _productId;

  void _toggleError(String? err) {
    _error = err;
    notifyListeners();
  }

  void _toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }
  void _toggleFavLoading(String? id) {
    _productId = id;
    notifyListeners();
  }

  void clearFavorites() {
    _productList.clear();
    notifyListeners();
  }
  Future<void> getFavorites() async {
    try {
      _toggleError(null);
      _toggleLoading(true);
      final response = await _favoritesDataSource.getFavorites();
      _productList.clear();
      _productList.addAll(response?.productList ?? []);
      _toggleLoading(false);
      notifyListeners();
    } catch (e) {
      _toggleLoading(false);
      _toggleError(e.toString());
    }
  }

  Future<void> addToFavorites({required String productId}) async {
    try {
      _toggleFavLoading(productId);
      final product = await _favoritesDataSource.addToFavorites(productId: productId);
      if (product != null) {
        _productList.add(product);
        notifyListeners();
      }
      _toggleFavLoading(null);
    } catch (e) {
      log(e.toString());
      _toggleFavLoading(null);
    }
  }

  Future<void> removeFromFavorites({required String productId}) async {
    try {
      _toggleFavLoading(productId);
      final product = await _favoritesDataSource.removeFromFavorites(productId: productId);
      if (product != null) {
        _productList.removeWhere((element) => element.id == product.id);
        notifyListeners();
      }
      _toggleFavLoading(null);
    } catch (e) {
      log(e.toString());
      _toggleFavLoading(null);
    }
  }
}