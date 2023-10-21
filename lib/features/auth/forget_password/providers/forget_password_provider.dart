import 'package:flutter/material.dart';
import 'package:wssal/features/auth/forget_password/data/data_source/forget_password_data_source.dart';

class ForgetPasswordProvider extends ChangeNotifier {
  final _forgetPasswordDataSource = ForgetPasswordDataSource();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  bool get loading => _loading;
  bool showPassword = true;

  void showHidePassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void _changeLoading(bool val) {
    _loading = val;
    notifyListeners();
  }

  Future<String?> forgetPassword() async {
    _changeLoading(true);
    try {
       await _forgetPasswordDataSource.forgetPassword(
        body: {
          "user": phoneController.text,
          "new_password": passwordController.text,
        },
      );
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
