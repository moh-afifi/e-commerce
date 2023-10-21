import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class DiscountDataSource {
  final _apiHandler = ApiHandler();

  Future<ProductModel?> getDiscountProducts() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.api.get_offers_items.get_offers_items',
      method: APIMethod.get,
      formData: FormData.fromMap({
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
      }),
    );

    return await compute<Map<String, dynamic>, ProductModel?>(
      ProductModel.fromJson,
      response,
    );
  }
}
