import 'package:flutter/material.dart';
import 'package:wssal/features/notifications/data/data_source/notification_data_source.dart';
import 'package:wssal/features/notifications/data/models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  NotificationProvider(){
    getNotifications();
  }
  final _notificationDataSource = NotificationDataSource();

  List<NotificationModel> _notificationList = [];

  List<NotificationModel> get notificationList => _notificationList;

  bool _loading = false;

  bool get loading => _loading;

  String? _error;

  String? get error => _error;

  void _changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  void _toggleError(String? err) {
    _error = err;
    notifyListeners();
  }

  Future<void> getNotifications() async {
    _changeLoading(true);
    _toggleError(null);
    try {
      final notificationModel = await _notificationDataSource.getNotifications();
      _notificationList = notificationModel?.notificationsList ?? [];
      _changeLoading(false);
    } catch (e) {
      _changeLoading(false);
      _toggleError(e.toString());
    }
  }
}
