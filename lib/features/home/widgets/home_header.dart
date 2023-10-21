import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/providers/user_provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/notifications/screens/notification_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(builder: (context) {
            final userName = context.read<UserProvider>().userModel?.name;
            if (userName != null) {
              return Text(
                'مرحباً بك ' '$userName',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              );
            }
            return const SizedBox.shrink();
          }),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                // Colors.black,
                AppColors.secondColor,
                BlendMode.modulate,
              ),
              child: Lottie.asset(
                LottieFiles.$63788_bell_icon_notification,
                repeat: true,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
