import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';

class AppLoader extends StatelessWidget {
  final double? width;
  final double? height;

  const AppLoader({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}
