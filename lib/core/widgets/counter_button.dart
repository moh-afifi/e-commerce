import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.iconColor,
    this.size,
    this.iconSize,
  }) : super(key: key);
  final VoidCallback onTap;
  final Color iconColor;
  final IconData icon;
  final double? size;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size ?? 35,
        width: size ?? 35,
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: iconSize ?? 25,
          ),
        ),
      ),
    );
  }
}
