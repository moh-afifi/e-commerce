import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/features/support/data/data_source/support_data_source.dart';

class SupportProvider extends ChangeNotifier {
  final _supportDataSource = SupportDataSource();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  bool _loading = false;

  bool get loading => _loading;

  void _changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  Future<String?> sendMessage() async {
    final data = {
      "name": GetIt.instance<SharedPreferences>().getString('userId'),
      "subject": subjectController.text,
      "description": messageController.text,
      "mobile": phoneController.text,
    };
    _changeLoading(true);
    try {
      await _supportDataSource.sendMessage(data: data);
      _changeLoading(false);
      return null;
    } catch (e) {
      _changeLoading(false);
      return e.toString();
    }
  }
}
