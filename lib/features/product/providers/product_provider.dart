import 'package:flutter/material.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider({required Product product, required bool isInCart, required String? cartUnitId})
      : _product = product {
    _initData(isInCart: isInCart, cartUnitId: cartUnitId);
  }

  void _initData({required bool isInCart, required String? cartUnitId}) {
    if (_product.productUnitsList.isNotEmpty) {
      if (isInCart) {
        _productUnit = _product.productUnitsList.singleWhere((unit) => unit?.id == cartUnitId);
        unitsList=[_productUnit];
      } else {
        _productUnit = _product.productUnitsList.first;
        unitsList= _product.productUnitsList;
      }
      _unitPrice = _productUnit?.price ?? 0;
    } else {
      productAvailable = false;
    }

    _isFavorite = _product.isFavorite;
  }


  List<ProductUnit?> unitsList=[];
  bool productAvailable = true;
  final Product _product;

  Product get product => _product;

  ProductUnit? _productUnit;

  ProductUnit? get productUnit => _productUnit;

  late bool _isFavorite;

  bool get isFavorite => _isFavorite;

  double _unitPrice = 0;

  double get unitPrice => _unitPrice;

  double get price => _unitPrice * _amount;

  int _amount = 1;

  int get amount => _amount;

  void increaseAmount() {
    _amount++;

    notifyListeners();
  }

  void decreaseAmount() {
    if (_amount == 1) return;
    _amount--;

    notifyListeners();
  }

  void chooseProductUnit(ProductUnit? unit, {notify = true}) {
    _productUnit = unit;
    _unitPrice = _productUnit?.price ?? 0;
    notifyListeners();
  }

  void toggleFav() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }
}
