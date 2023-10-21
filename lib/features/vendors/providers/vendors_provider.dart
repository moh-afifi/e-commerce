import 'package:flutter/material.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/vendors/data/data_source/vendor_data_source.dart';
import 'package:wssal/features/vendors/data/models/vendors_model.dart';

class VendorProvider extends ChangeNotifier {
  VendorProvider(){
    getVendors();
  }
  final VendorDataSource _vendorDataSource = VendorDataSource();
  List<Vendor> _vendorsList = [];

  List<Vendor> get vendorsList => _vendorsList;
  List<Product> _productList = [];

  List<Product> get productList => _productList;

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

  Future<void> getVendors() async {
    try {
      _toggleLoading(true);
      _toggleError(null);
      final response = await _vendorDataSource.getVendors();
      _vendorsList = response?.vendorsList ?? [];
      notifyListeners();
      _toggleLoading(false);
    } catch (e) {
      _toggleLoading(false);
      _toggleError(e.toString());
    }
  }

  Future<List<Product>> getVendorProducts({required String vendorId}) async {
    final response =
        await _vendorDataSource.getVendorProducts(vendorId: vendorId);
    _productList = response?.productList ?? [];
    return _productList;
  }
}
