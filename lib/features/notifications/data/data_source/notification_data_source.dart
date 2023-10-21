import 'package:flutter/foundation.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/features/notifications/data/models/notification_model.dart';

class NotificationDataSource {
  final _apiHandler = ApiHandler();

  Future<NotificationsModel?> getNotifications() async {
    final response = await _apiHandler.call(
      path: 'wssal_api.auth.notifications',
      method: APIMethod.get,
    );

    if (response['data'] == null) {
      throw response['message'] ?? "حدث خطأ في البيانات";
    }

    return await compute<Map<String, dynamic>, NotificationsModel?>(
      NotificationsModel.fromJson,
      response,
    );
  }
}
