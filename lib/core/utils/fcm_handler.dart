import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wssal/app.dart';
import 'package:wssal/features/root/screens/root_screen.dart';

import '../constants/constants.dart';
import 'app_utils.dart';

class FCM {
  static final FCM instance = FCM._internal();

  factory FCM() => instance;

  FCM._internal();

  static late final FirebaseMessaging _firebaseMessaging;

  static Future<void> init() async {
    if (kIsWeb) return;

    try {
      await _requestPermissions();

      _firebaseMessaging = FirebaseMessaging.instance;

      await _firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      final settings = await _firebaseMessaging.requestPermission(
        alert: false,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        log("FCM AuthorizationStatus : ${settings.authorizationStatus.name}");
      }

      await fetchDeviceToken();

      FirebaseMessaging.onMessage.listen(
        _firebaseMessagingHandler,
      );

      FirebaseMessaging.onMessageOpenedApp.listen(
        _firebaseMessagingOpenedAppHandler,
      );

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    } catch (e) {
      if (kDebugMode) log("Error initializing FCM : ${e.toString()}");
    }
  }

  static Future<void> _requestPermissions() async {
    bool notificationIsGranted = await Permission.notification.isGranted;

    if (kDebugMode) {
      log("Notifications is Granted : $notificationIsGranted");
    }

    if (notificationIsGranted) return;

    await [Permission.notification].request();
  }

  static Future<void> fetchDeviceToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      await GetIt.instance<SharedPreferences>().setString(Constants.deviceToken, token ?? '');
      if (kDebugMode) log("FCM device token : $token");
    } catch (e) {
      if (kDebugMode) log("Error fetching Token : $e");
    }
  }

  static Future<void> _onNotificationAction(RemoteMessage message) async {
    if (kDebugMode) {
      log("Handling  _onNotificationAction notification: "
          "${message.notification?.toMap().toString()},\n "
          "data: ${message.data.toString()}");
    }

    RemoteNotification? notification = message.notification;

    if (notification != null && !kIsWeb) {
      AppUtils.showInAppNotification(
        title: notification.title,
        body: notification.body,
        onTap: () => navigate(data: message.data),
      );
    }
  }

  static void navigate({required Map<String, dynamic>? data}) {
    MyApp.navigatorKey?.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const RootScreen(),
      ),
      (route) => route.isFirst,
    );
  }

  static Future<void> _firebaseMessagingOpenedAppHandler(
    RemoteMessage message,
  ) async {
    if (kDebugMode) {
      log("Handling an OpenedApp message: ${message.messageId}");
    }

    navigate(data: message.data);
  }

  static Future<void> _firebaseMessagingHandler(
    RemoteMessage message,
  ) async {
    if (kDebugMode) log("Handling Messaging message : ${message.messageId}");

    await _onNotificationAction(message);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    if (kDebugMode) log("Handling a background message: ${message.messageId}");
  }
}
