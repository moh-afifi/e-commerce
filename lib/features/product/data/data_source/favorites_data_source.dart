import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';

class ProductDataSource {
  final _apiHandler = ApiHandler();

  Future<void> monitorProduct({required String productId}) async {
    try {
      await _apiHandler.call(
        path: 'wssal_api.api.monitoring_items.create_monitoring_items',
        method: APIMethod.post,
        formData: FormData.fromMap({
          "customer": GetIt.instance<SharedPreferences>().getString('userId'),
          "item": productId,
        }),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
