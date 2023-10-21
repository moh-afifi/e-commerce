import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wssal/core/models/user_model.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/auth/register/data/models/entity_model.dart';

class RegisterDataSource {
  final _apiHandler = ApiHandler();

  Future<UserModel?> register({required Map<String, dynamic> body}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.signup',
      method: APIMethod.post,
      formData: FormData.fromMap(body),
    );

    if (response['data'] == null) throw response['message'] ?? "حدث خطأ في البيانات";

    return await compute<Map<String, dynamic>, UserModel?>(
      UserModel.fromJson,
      response['data'],
    );
  }

  Future<EntityModel?> getRegions() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.get_regions',
      method: APIMethod.get,
    );

    return await compute<Map<String, dynamic>, EntityModel?>(
      EntityModel.fromJson,
      response,
    );
  }

  Future<EntityModel?> getEntityType() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.get_facility_types',
      method: APIMethod.get,
    );

    return await compute<Map<String, dynamic>, EntityModel?>(
      EntityModel.fromJson,
      response,
    );
  }
}
