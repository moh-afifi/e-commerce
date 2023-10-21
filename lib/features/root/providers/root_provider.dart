import 'package:flutter/material.dart';
import 'package:wssal/features/root/data/data_source/root_data_source.dart';
import 'package:wssal/features/root/data/models/app_state_model.dart';

class RootProvider extends ChangeNotifier {
  final RootDataSource _rootDataSource = RootDataSource();
  AppSateModel? _appSateModel;

  AppSateModel? get appSateModel => _appSateModel;
  int currentIndex = 0;

  void changeIndex(int val) {
    currentIndex = val;
    notifyListeners();
  }

  Future<AppSateModel?> checkAppState() async {
    try {
      _appSateModel = await _rootDataSource.checkAppState();
      return _appSateModel;
    } catch (e) {
      return null;
    }
  }
}
