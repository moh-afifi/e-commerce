// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/constants/constants.dart';
import 'package:wssal/core/providers/user_provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/features/auth/login/data/data_source/login_data_source.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/favorites/providers/favorites_provider.dart';

class LoginProvider extends ChangeNotifier {
  final _loginDataSource = LoginDataSource();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  bool get loading => _loading;
  bool showPassword = false;

  void showHidePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void _changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  Future<String?> login(BuildContext context) async {
    _changeLoading(true);
    try {
      final user = await _loginDataSource.login(
        body: {
          "usr": phoneController.text,
          "pwd": passwordController.text,
          "device_token": GetIt.instance<SharedPreferences>().getString(Constants.deviceToken)
        },
      );
      await AppUtils.cacheUserData(user);
      context.read<UserProvider>().getUser();
      await context.read<CartProvider>().getCartProducts();
      await context.read<FavoriteProvider>().getFavorites();
      _changeLoading(false);
      return null;
    } catch (e) {
      _changeLoading(false);
      return e.toString();
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
