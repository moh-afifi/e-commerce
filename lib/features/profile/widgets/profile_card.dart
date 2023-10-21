import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wssal/core/utils/color_utils.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
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
            ],
          ),
          const Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
