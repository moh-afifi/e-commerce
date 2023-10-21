import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/vendors/data/models/vendors_model.dart';

class VendorDataSource {
  final _apiHandler = ApiHandler();

  Future<VendorsModel?> getVendors() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.get_vendors',
      method: APIMethod.get,
    );

    return await compute<Map<String, dynamic>, VendorsModel?>(
      VendorsModel.fromJson,
      response,
    );
  }

  Future<ProductModel?> getVendorProducts({required String vendorId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.get_brand_items',
      method: APIMethod.post,
      formData: FormData.fromMap({
        "id": vendorId,
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
      }),
    );

    return await compute<Map<String, dynamic>, ProductModel?>(
      ProductModel.fromJson,
      response,
    );
  }
}
