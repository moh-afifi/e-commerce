import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class SearchDataSource {
  final _apiHandler = ApiHandler();

  Future<ProductModel?> searchProducts({required String searchWord}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.search_for_item',
      method: APIMethod.get,
      formData: FormData.fromMap({
        "item": searchWord,
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
      }),
    );

    return await compute<Map<String, dynamic>, ProductModel?>(
      ProductModel.fromJson,
      response,
    );
  }

  Future<ProductModel?> scanProducts({required String barcode}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.item_barcode',
      method: APIMethod.get,
      formData: FormData.fromMap({
        "barcode": barcode,
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
      }),
    );

    return await compute<Map<String, dynamic>, ProductModel?>(
      ProductModel.fromJson,
      response,
    );
  }
}
