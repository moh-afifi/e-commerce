import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/address/data/models/address_model.dart';

class AddressDataSource {
  final _apiHandler = ApiHandler();

  Future<AddressModel?> getAddresses() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.get_addresses',
      method: APIMethod.get,
      formData: FormData.fromMap(
          {"user_id": GetIt.instance<SharedPreferences>().getString('userId')}),
    );

    if (response['data'] == null) {
      throw response['message'] ?? "حدث خطأ في البيانات";
    }

    return await compute<Map<String, dynamic>, AddressModel?>(
      AddressModel.fromJson,
      response,
    );
  }

  Future<Address?> addAddress({required Map<String, dynamic> data}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.create_address',
      method: APIMethod.post,
      formData: FormData.fromMap(data),
    );

    if (response['data'] == null) {
      throw response['message'] ?? "حدث خطأ في البيانات";
    }

    return await compute<Map<String, dynamic>, Address?>(
      Address.fromJson,
      response['data'],
    );
  }

  Future<Address?> updateAddress({required Map<String, dynamic> data}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.update_address',
      method: APIMethod.put,
      formData: FormData.fromMap(data),
    );

    if (response['data'] == null) {
      throw response['message'] ?? "حدث خطأ في البيانات";
    }

    return await compute<Map<String, dynamic>, Address?>(
      Address.fromJson,
      response['data'],
    );
  }

  Future<bool> deleteAddress({required String addressId}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.delete_address',
      method: APIMethod.delete,
      formData: FormData.fromMap({
        "id": addressId,
      }),
    );

    return response['message'].toString() == "success";
  }
}
