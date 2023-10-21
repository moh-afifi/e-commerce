import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/features/cart/data/data_source/cart_data_source.dart';
import 'package:wssal/features/cart/data/models/cart_item_model.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

import '../data/models/delivery_time.dart';

class CartProvider extends ChangeNotifier {
  CartProvider() {
    getCartProducts();
  }

  final CartDataSource _cartDataSource = CartDataSource();
  final TextEditingController notesController = TextEditingController();
  List<ItemModel> itemsList = [];

  double get totalPrice {
    double total = 0;
    final list = itemsList.where((item) => item.maxQuantity != 0).toList();
    for (var item in list) {
      double unitPrice = item.unitPrice ?? 0;
      double qty = item.qty ?? 0;
      total += unitPrice * qty;
    }
    return total;
  }

  bool _loading = false;

  bool get loading => _loading;

  bool _actionLoading = false;

  bool get actionLoading => _actionLoading;
  bool _createOrderLoading = false;

  bool get createOrderLoading => _createOrderLoading;
  String? _error;

  String? get error => _error;

  String? _selectedTimeId;

  String? get selectedTimeId => _selectedTimeId;

  DateTime _deliveryDate=DateTime.now();

  DateTime get deliveryDate => _deliveryDate;

  final List<Product> _productList = [];

  List<Product> get productList => _productList;

  String? _selectedAddressId;

  String? get selectedAddressId => _selectedAddressId;

  void resetData() {
    _selectedAddressId = null;
    _deliveryDate = DateTime.now();
    _selectedTimeId = null;
    notesController.clear();
    notifyListeners();
  }

  void changeSelectedTime(String? id) {
    _selectedTimeId = id;
    notifyListeners();
  }

  void changeAddressId(String? id) {
    _selectedAddressId = id;
    notifyListeners();
  }

  void changeDeliveryDate(DateTime date) {
    _deliveryDate = date;
    notifyListeners();
  }

  void _toggleLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void _toggleActionLoading(bool val) {
    _actionLoading = val;
    notifyListeners();
  }

  void _toggleCreateOrderLoading(bool val) {
    _createOrderLoading = val;
    notifyListeners();
  }

  void _toggleError(String? err) {
    _error = err;
    notifyListeners();
  }

  void clearCart() {
    _productList.clear();
    itemsList.clear();
    notifyListeners();
  }

  void updateQuantity({required Product? product, required double quantity}) {
    final item = itemsList.singleWhere((element) => element.uniqueId == product?.uniqueId);
    itemsList.removeWhere((element) => element.uniqueId == product?.uniqueId);
    itemsList.add(
      ItemModel(
        itemCode: item.itemCode,
        uom: item.uom,
        qty: quantity,
        unitPrice: item.unitPrice,
        maxQuantity: item.maxQuantity,
        uniqueId: item.uniqueId,
      ),
    );
    notifyListeners();
    // print(List.generate(itemsList.length, (index) => itemsList[index].toJson()));
  }


  Future<String?> removeFromCart(
      {required String itemCode,
      required String unitId,
      required String uniqueId}) async {
    try {
      _toggleActionLoading(true);
      final product = await _cartDataSource.removeFromCart(
          itemCode: itemCode, unitId: unitId);
      if (product != null) {
        _productList.removeWhere((element) => element.uniqueId == uniqueId);
        itemsList.removeWhere((element) => element.uniqueId == uniqueId);
        notifyListeners();
      }
      _toggleActionLoading(false);
      return null;
    } catch (e) {
      _toggleActionLoading(false);
      return e.toString();
    }
  }

  Future<void> getCartProducts() async {
    try {
      _toggleLoading(true);
      _toggleError(null);
      final response = await _cartDataSource.getCartProducts();
      _productList.clear();
      itemsList.clear();
      _productList.addAll(response?.productList ?? []);

      for (var product in _productList) {
        if(product.chosenUnit?.isAvailable??false){
          itemsList.add(
            ItemModel(
              itemCode: product.id,
              uniqueId: product.uniqueId,
              uom: product.chosenUnit?.id,
              qty: product.chosenUnit?.quantity,
              unitPrice: product.chosenUnit?.price,
              maxQuantity: product.chosenUnit?.maxAmount,

            ),
          );
        }
      }
      notifyListeners();
      _toggleLoading(false);
    } catch (e) {
      _toggleLoading(false);
      _toggleError(e.toString());
    }
  }

  Future<String?> addToCart({
    required String itemCode,
    required String itemUnit,
    required int itemQuantity,
  }) async {
    try {
      final body = {
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
        "item_code": itemCode,
        "unit": itemUnit,
        "qty": itemQuantity,
      };
      _toggleActionLoading(true);
      final product = await _cartDataSource.addToCart(body: body);
      if (product != null) {
        getCartProducts();
      }
      _toggleActionLoading(false);
      return null;
    } catch (e) {
      _toggleActionLoading(false);
      return e.toString();
    }
  }

  Future<String?> createOrder() async {
    try {
      _toggleCreateOrderLoading(true);
      final orderList =
          itemsList.where((item) => item.maxQuantity != 0).toList();
      await _cartDataSource.createOrder(
        date: _deliveryDate.toString(),
        addressId: _selectedAddressId ?? '-1',
        deliveryTime: _selectedTimeId ?? '-1',
        note: notesController.text,
        itemsList: List.generate(
          orderList.length,
          (index) => orderList[index].toJson(),
        ),
      );
      _toggleCreateOrderLoading(false);
      clearCart();
      return null;
    } catch (e) {
      _toggleCreateOrderLoading(false);
      return e.toString();
    }
  }

  Future<List<DeliveryTime>> getDeliveryTimes() async {
    final response = await _cartDataSource.getDeliveryTimes();
    return response?.deliveryTimesList ?? [];
  }


// void updateUnit(
//     {required Product? product,
//     required String? unitId,
//     required double unitPrice}) {
//   final item = itemsList
//       .singleWhere((element) => element.uniqueId == product?.uniqueId);
//   itemsList.removeWhere((element) => element.uniqueId == product?.uniqueId);
//   itemsList.add(
//     ItemModel(
//       itemCode: item.itemCode,
//       uom: unitId,
//       qty: item.qty,
//       unitPrice: unitPrice,
//       maxQuantity: item.maxQuantity,
//       uniqueId: item.uniqueId,
//     ),
//   );
//   notifyListeners();
//   // print(List.generate(itemsList.length, (index) => itemsList[index].toJson()));
// }

}
