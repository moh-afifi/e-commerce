import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wssal/core/utils/color_utils.dart';

class SupportCard extends StatelessWidget {
  const SupportCard(
      {Key? key, required this.label, required this.icon, required this.onTap})
      : super(key: key);
  final IconData icon;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                FaIcon(
                  icon,
                  color: AppColors.primaryColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(label),
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                  size: 20,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
