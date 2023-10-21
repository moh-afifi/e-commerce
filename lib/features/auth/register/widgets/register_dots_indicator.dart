import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';

class RegisterDotIndicator extends StatelessWidget {
  const RegisterDotIndicator({Key? key,required this.position}) : super(key: key);
  final double position;

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: 3,
      position: position,
      decorator: const DotsDecorator(
        color: Colors.grey, // Inactive color
        activeColor: AppColors.secondColor,
      ),
    );
  }
}
