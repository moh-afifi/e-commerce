import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key, required this.onPressed, required this.label})
      : super(key: key);
  final void Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: AppColors.primaryColor,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          padding: const EdgeInsets.all(10),
        ),
        child:  Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
