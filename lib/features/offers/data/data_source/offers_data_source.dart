import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/offers/data/models/offers_model.dart';
import 'package:wssal/features/product/data/models/product_model.dart';

class OffersDataSource {
  final _apiHandler = ApiHandler();

  Future<OffersModel?> getOffers() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.get_offers',
      method: APIMethod.get,
    );

    return await compute<Map<String, dynamic>, OffersModel?>(
      OffersModel.fromJson,
      response,
    );
  }

  Future<ProductModel?> getOfferProducts({required String offerId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.inventory.get_offer_details',
      method: APIMethod.post,
      formData: FormData.fromMap({
        "id": offerId,
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
      }),
    );
    return await compute<Map<String, dynamic>, ProductModel?>(
      ProductModel.fromJson,
      response,
    );
  }
}
