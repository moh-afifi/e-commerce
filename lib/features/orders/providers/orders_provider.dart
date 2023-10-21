import 'package:flutter/material.dart';
import 'package:wssal/features/orders/data/data_source/orders_data_source.dart';
import 'package:wssal/features/orders/data/models/invoice_details.dart';
import 'package:wssal/features/orders/data/models/orders_model.dart';

class OrdersProvider extends ChangeNotifier {
  final _ordersDateSource = OrdersDataSource();

  List<Invoice> _currentOrdersList = [];

  List<Invoice> get currentOrdersList => _currentOrdersList;

  List<Invoice> _expiredOrdersList = [];

  List<Invoice> get expiredOrdersList => _expiredOrdersList;

  bool _loading = false;

  bool get loading => _loading;

  bool _actionLoading = false;

  bool get actionLoading => _actionLoading;
  String? _error;

  String? get error => _error;

  void _changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void _changeActionLoading(bool val) {
    _actionLoading = val;
    notifyListeners();
  }

  void _toggleError(String? err) {
    _error = err;
    notifyListeners();
  }

  Future<void> getOrders() async {
    _changeLoading(true);
    _toggleError(null);
    try {
      final ordersModel = await _ordersDateSource.getOrders();
      final ordersList = ordersModel?.ordersList.reversed.toList() ?? [];
      _currentOrdersList = ordersList
          .where((element) => element.status != 'تم التسليم')
          .toList();
      _expiredOrdersList = ordersList
          .where((element) => element.status == 'تم التسليم')
          .toList();
      _changeLoading(false);
    } catch (e) {
      _changeLoading(false);
      _toggleError(e.toString());
    }
  }

  Future<List<Item>> getInvoiceDetails({required String invoiceId}) async {
    final response =
        await _ordersDateSource.getInvoiceDetails(invoiceId: invoiceId);
    return response?.itemsList ?? [];
  }

  Future<bool> cancelOrders({required String orderId}) async {
    _changeActionLoading(true);
    try {
      final res = await _ordersDateSource.cancelOrder(orderId: orderId);
      _changeActionLoading(false);
      _currentOrdersList.removeWhere((order) => order.orderNo == orderId);
      notifyListeners();
      return res;
    } catch (e) {
      _changeActionLoading(false);
      return false;
    }
  }
}
