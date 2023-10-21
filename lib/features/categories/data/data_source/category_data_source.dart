import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/categories/data/models/categories_model.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class CategoryDataSource {
  final _apiHandler = ApiHandler();

  Future<CategoriesModel?> getCategories() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.get_categories',
      method: APIMethod.get,
    );

    return await compute<Map<String, dynamic>, CategoriesModel?>(
      CategoriesModel.fromJson,
      response,
    );
  }

  Future<ProductModel?> getCategoryProducts({required String subCategoryId, required String categoryId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.get_category_items',
      method: APIMethod.post,
      formData: FormData.fromMap({
        if(subCategoryId != "") "id": subCategoryId,
        if(categoryId != "") "category_id": categoryId,
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
      }),
    );

    return await compute<Map<String, dynamic>, ProductModel?>(
      ProductModel.fromJson,
      response,
    );
  }
}
