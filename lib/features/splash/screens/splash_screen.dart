import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/providers/user_provider.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/root/screens/root_screen.dart';

import '../../onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    const delay = Duration(seconds: 4);
    Future.delayed(delay, () => onTimerFinished());
  }

  void onTimerFinished() {
    final token = GetIt.instance<SharedPreferences>().getString('token');
    final bool isGuest = token == null || token == '';
    if (!isGuest) {
      context.read<UserProvider>().getUser();
      ApiHandler.instance.setUserToken(token);
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        settings: const RouteSettings(name: "/Root"),
        builder: (BuildContext context) {
          return isGuest ? const OnBoardingScreen() : const RootScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo-word.png",
              height: 200,
              width: 200,
            ),
            const Text(
              'بوابة انتقاء بضاعتك',
              style: TextStyle(
                fontSize: 26,
                color: AppColors.thirdColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
