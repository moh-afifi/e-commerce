import 'dart:async';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'app.dart';
import 'core/utils/fcm_handler.dart';
import 'firebase_options.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
      name:  "Wssal",
    );
    await registerRepositories();
    await FCM.init();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor),
    );

    runApp(
      const MyApp(),
    );
  }, (error, stack) => log(error.toString()));
}

Future<void> registerRepositories() async {
  final SharedPreferences cachePlugin = await SharedPreferences.getInstance();
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<SharedPreferences>(cachePlugin);
}
