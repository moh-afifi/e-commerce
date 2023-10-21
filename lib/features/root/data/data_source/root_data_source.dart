import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/root/data/models/app_state_model.dart';

class RootDataSource {
  final _apiHandler = ApiHandler();

  Future<AppSateModel?> checkAppState() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.user_status',
      method: APIMethod.get,
      formData: FormData.fromMap({
        "user_id": GetIt.instance<SharedPreferences>().getString('userId'),
      }),
    );

    if (response['data'] == null) throw response['message'] ?? "حدث خطأ في البيانات";

    return await compute<Map<String, dynamic>, AppSateModel?>(
      AppSateModel.fromJson,
      response['data'],
    );
  }
}
