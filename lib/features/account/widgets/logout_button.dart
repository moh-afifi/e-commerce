import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/features/auth/login/screens/login_screen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 0,
          backgroundColor: Colors.red,
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            const Text(
              "تسجيل الخروج",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Container()
          ],
        ),
        onPressed: () {
          GetIt.instance<SharedPreferences>().clear();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (BuildContext context) {
              return const LoginScreen();
            },
          ), (Route<dynamic> route) => false);
        },
      ),
    );
  }
}