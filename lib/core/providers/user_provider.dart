import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/constants/constants.dart';
import 'package:wssal/core/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    getUser();
  }

  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  void getUser() {
    final userFromCaches = GetIt.instance<SharedPreferences>().getString(Constants.user);
    if (userFromCaches != null) {
      final userAsJson = jsonDecode(userFromCaches);
      final user = UserModel.fromJson(userAsJson);
      _userModel = user;
    }
  }
}
