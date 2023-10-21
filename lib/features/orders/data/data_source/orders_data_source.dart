import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/orders/data/models/orders_model.dart';

import '../models/invoice_details.dart';

class OrdersDataSource {
  final _apiHandler = ApiHandler();

  Future<InvoicesModel?> getOrders() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.cart.get_orders',
      method: APIMethod.get,
      formData: FormData.fromMap(
        {"user_id": GetIt.instance<SharedPreferences>().getString('userId')},
      ),
    );

    if (response['data'] == null) {
      throw response['message'] ?? "حدث خطأ في البيانات";
    }

    return await compute<Map<String, dynamic>, InvoicesModel?>(
      InvoicesModel.fromJson,
      response,
    );
  }

  Future<InvoiceDetails?> getInvoiceDetails({required String invoiceId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.api.get_invoice_details.get_invoice_details',
      method: APIMethod.get,
      formData: FormData.fromMap(
        {
          "invoice_number": invoiceId,
        },
      ),
    );

    return await compute<Map<String, dynamic>, InvoiceDetails?>(
      InvoiceDetails.fromJson,
      response["message"],
    );
  }

  Future<bool> cancelOrder({required String orderId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.cart.cancel_order',
      method: APIMethod.put,
      formData: FormData.fromMap(
        {
          "id": orderId,
        },
      ),
    );

    if (response['data'] == null) {
      return false;
    }

    return response['message'] == 'success';
  }
}
