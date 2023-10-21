import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wssal/core/utils/color_utils.dart';

class AccountItem extends StatelessWidget {
  const AccountItem(
      {Key? key,
      required this.label,
      required this.navigateTo,
      required this.svgPath})
      : super(key: key);
  final String svgPath, label;
  final Widget navigateTo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => navigateTo,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: [
            SizedBox(
              width: 20,
              height: 20,
              child: SvgPicture.asset(
                svgPath,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
