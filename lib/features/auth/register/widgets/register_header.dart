import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Selector<RegisterProvider, int>(
              shouldRebuild: (previous, next) => previous != next,
              selector: (context, provider) => provider.index,
              builder: (context, index, _) {
                return InkWell(
                  onTap: () {
                    final registerProvider = context.read<RegisterProvider>();
                    if (index == 0) {
                      Navigator.pop(context);
                    } else {
                      registerProvider.pageController.previousPage(
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_back,
                  ),
                );
              },
            ),
            const SizedBox.shrink(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'تسجيل مستخدم جديد',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              "assets/images/logo-word.png",
              height: 55,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
