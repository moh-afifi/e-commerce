import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

import '../models/delivery_time.dart';

class CartDataSource {
  final _apiHandler = ApiHandler();

  Future<ProductModel?> getCartProducts() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.cart.get_cart_items',
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

  Future<Product?> addToCart({required Map<String, dynamic> body}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.cart.add_to_cart',
      method: APIMethod.post,
      formData: FormData.fromMap(body),
    );

    if(response['data'] != null && response['data'] is Map<String,dynamic>){
      return await compute<Map<String, dynamic>, Product?>(
        Product.fromJson,
        response['data'],
      );
    }else if(response['message'] !=null && response['message'] is String){
      throw response['message'] ;
    }else{
      throw  "حدث خطأ في البيانات";
    }

  }

  Future<Product?> removeFromCart({required String itemCode,required String unitId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.cart.remove_from_cart',
      method: APIMethod.put,
      formData: FormData.fromMap({
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
        "item_code": itemCode,
        "unit": unitId,
      }),
    );

    return await compute<Map<String, dynamic>, Product?>(
      Product.fromJson,
      response['data'],
    );
  }

  Future<void> createOrder({
    required List<Map<String, dynamic>> itemsList,
    required String addressId,
    required String date,
    required String deliveryTime,
    required String note,
  }) async {
    final response = await _apiHandler.call(
        path: 'wssal_api.cart.creat_order',
        method: APIMethod.post,
        body: {
          "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
          "created_at": date,
          "delivery_date": date,
          "address_id": addressId,
          "items": itemsList,
          "delivery_time": deliveryTime,
          "note": note,
        });

    await compute<Map<String, dynamic>, Product?>(
      Product.fromJson,
      response['data'],
    );
  }

  Future<DeliveryTimesModel?> getDeliveryTimes() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.cart.get_delivery_times',
      method: APIMethod.get,
    );
    return await compute<Map<String, dynamic>, DeliveryTimesModel?>(
      DeliveryTimesModel.fromJson,
      response,
    );
  }
}
