import 'package:flutter/material.dart';
import 'package:wssal/features/offers/data/data_source/offers_data_source.dart';
import 'package:wssal/features/offers/data/models/offers_model.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class OffersProvider extends ChangeNotifier {
  OffersProvider() {
    getOffers();
  }

  final OffersDataSource _offersDataSource = OffersDataSource();
  List<Offer> _offersList = [];

  List<Offer> get offersList => _offersList;

  List<Product> _productList = [];

  List<Product> get productList => _productList;
  bool _loading = false;

  bool get loading => _loading;
  String? _error;

  String? get error => _error;

  int _offerIndex = 0;

  int get offerIndex => _offerIndex;

  void changeOfferIndex(int index) {
    _offerIndex = index;
    notifyListeners();
  }

  void _toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void _toggleError(String? err) {
    _error = err;
    notifyListeners();
  }

  Future<void> getOffers() async {
    try {
      _toggleLoading(true);
      _toggleError(null);
      final response = await _offersDataSource.getOffers();
      _offersList = response?.offersList ?? [];
      notifyListeners();
      _toggleLoading(false);
    } catch (e) {
      _toggleLoading(false);
      _toggleError(e.toString());
    }
  }

  Future<List<Product>> getOffersProducts({required String offerId}) async {
    final response = await _offersDataSource.getOfferProducts(offerId: offerId);
    _productList = response?.productList ?? [];
    return _productList;
  }
}
