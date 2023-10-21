import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:wssal/core/models/user_model.dart';
import 'package:wssal/core/utils/api_handler.dart';

class LoginDataSource {
  final _apiHandler = ApiHandler();

  Future<UserModel?> login(
      {required Map<String, dynamic> body}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.login',
      method: APIMethod.post,
      formData: FormData.fromMap(body),
    );

    if (response['data'] == null) throw response['message']??"حدث خطأ في البيانات";

    return await compute<Map<String, dynamic>, UserModel?>(
      UserModel.fromJson,
      response['data'],
    );
  }
}
