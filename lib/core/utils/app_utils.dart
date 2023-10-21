import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get_it/get_it.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';
import 'package:wssal/core/constants/constants.dart';
import 'package:wssal/core/models/user_model.dart';
import 'package:wssal/core/utils/api_handler.dart';
import 'package:wssal/core/utils/color_utils.dart';

abstract class AppUtils {
  static final borderSide = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.primaryColor,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(30),
  );

  static final borderSide15 = OutlineInputBorder(
    borderSide: const BorderSide(
      color: AppColors.primaryColor,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(15),
  );

  static void showSnackBar({
    required BuildContext context,
    required String message,
    bool isFailure = true,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: isFailure ? Colors.red : Colors.teal,
      ),
    );
  }

  static Future<void> cacheUserData(UserModel? user) async {
    if (user != null) {
      await GetIt.instance<SharedPreferences>().setString(Constants.user, json.encode(user.toJson()));
      await GetIt.instance<SharedPreferences>().setString('token', user.token ?? '');
      await GetIt.instance<SharedPreferences>().setString('userId', user.userId ?? '');
      ApiHandler.instance.setUserToken(user.token ?? '');
    }
  }

  static Future<void> showInAppNotification({
    String? title,
    String? body,
    Color? color,
    Function()? onTap,
  }) async {
    try {
      showSimpleNotification(
        InkWell(
          onTap: onTap,
          child: Text(
            title ?? 'Notification',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        subtitle: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              body ?? '',
              style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        leading: InkWell(
          onTap: onTap,
          child: Image.asset('assets/images/logo.png'),
        ),
        duration: const Duration(seconds: 5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10.0,
        ),
        elevation: 5.0,
        autoDismiss: true,
        slideDismissDirection: DismissDirection.up,
        background: Colors.white,
      );
      FlutterRingtonePlayer.playNotification();
      vibrate();
    } catch (e) {
      if (kDebugMode) log("Couldn't show notification : $e");
    }
  }

  static Future<void> vibrate({
    Duration duration = const Duration(milliseconds: 500),
    List<int> pattern = const [],
  }) async {
    try {
      final hasVibrator = (await Vibration.hasVibrator()) ?? false;

      if (!hasVibrator) {
        throw 'Device has no Vibrates !';
      }

      final hasCustomVibrations =
          (await Vibration.hasCustomVibrationsSupport()) ?? false;

      if (hasCustomVibrations) {
        await Vibration.vibrate(
          duration: duration.inMilliseconds,
          pattern: pattern,
        );
      } else {
        final intervals = duration.inMilliseconds ~/ 500;
        for (int i = 0; i < intervals; i++) {
          await Vibration.vibrate();
          await Future.delayed(const Duration(milliseconds: 500));
        }
      }
    } catch (e) {
      if (kDebugMode) log('Error vibrating device : $e');
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    return picked;
  }

  static Future makePhoneCall() async {
    StringBuffer url = StringBuffer("tel://01030332213");
    try {
      if (await canLaunchUrl(Uri.parse(url.toString()))) {
        await launchUrl(Uri.parse(url.toString()),
            mode: LaunchMode.platformDefault);
      } else {
        throw 'Try dial!';
      }
    } catch (e) {
      log('Error making phone call : $e');
    }
  }

  static Future openWhatsapp() async {
    String phone = '+201030332213';
    final androidUrl = "whatsapp://send?phone=$phone";
    var iosUrl = "https://api.whatsapp.com/send/?phone=$phone&text&type=phone_number&app_absent=0";
    final url = StringBuffer(Platform.isIOS ? iosUrl : androidUrl);

    try {
      if (await canLaunchUrl(Uri.parse(url.toString()))) {
        await launchUrl(Uri.parse(url.toString()),
            mode: LaunchMode.platformDefault);
      } else {
        throw 'Try dial!';
      }
    } catch (e) {
      log('Error sending Whatsapp : $e');
      String dial = 'tel://$phone';
      if (await canLaunchUrl(Uri.parse(dial))) {
        await launchUrl(Uri.parse(dial), mode: LaunchMode.platformDefault);
      }
    }
  }
}
