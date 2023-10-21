import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class FavoritesDataSource {
  final _apiHandler = ApiHandler();

  Future<ProductModel?> getFavorites() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.get_favorite_items',
      method: APIMethod.post,
      formData: FormData.fromMap({
        "user_id":  GetIt.instance<SharedPreferences>().getString('userId'),
      }),
    );

    return await compute<Map<String, dynamic>, ProductModel?>(
      ProductModel.fromJson,
      response,
    );
  }

  Future<Product?> addToFavorites({required String productId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.add_favorite',
      method: APIMethod.post,
      formData: FormData.fromMap({
        "user_id":  GetIt.instance<SharedPreferences>().getString('userId'),
        "item_code": productId,

      }),
    );

    return await compute<Map<String, dynamic>, Product?>(
      Product.fromJson,
      response['data'],
    );
  }


  Future<Product?> removeFromFavorites({required String productId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.remove_favorite',
      method: APIMethod.post,
      formData: FormData.fromMap({
        "user_id":  GetIt.instance<SharedPreferences>().getString('userId'),
        "item_code": productId,
      }),
    );

    return await compute<Map<String, dynamic>, Product?>(
      Product.fromJson,
      response['data'],
    );
  }
}
