import 'package:dio/dio.dart';
import 'package:wssal/core/utils/api_handler.dart';

class SupportDataSource {
  final _apiHandler = ApiHandler();

  Future<bool> sendMessage({required Map<String, dynamic> data}) async {
    final response = await _apiHandler.call(
      path: 'wssal_api.api.issue.create_issue',
      method: APIMethod.post,
      formData: FormData.fromMap(data),
    );
    if (response['status_code'] == 200) {
      return true;
    }else {
      throw  "حدث خطأ في البيانات";
    }
  }
}
