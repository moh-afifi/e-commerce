import 'package:flutter/material.dart';

import '../../core/utils/color_utils.dart';
import 'loading.dart';

class AppButton extends _Button {
  AppButton({
    Key? key,
    required String label,
    required Function()? onPressed,
    EdgeInsets? padding,
    double fontSize = 14.0,
    Color? textColor,
    EdgeInsets? margin,
    Color? borderColor,
    Color? backgroundColor,
    double? elevation,
    BorderRadius? borderRadius,
    bool isBusy = false,
    Widget? child,
    bool shrink = false,
    FontWeight fontWeight = FontWeight.w700,
    bool applyHomeNotch = false,
  }) : super(
    key: key,
    isBusy: isBusy,
    margin: margin,
    applyHomeNotch: applyHomeNotch,
    child: child ??
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            foregroundColor: textColor ?? Colors.white,
            elevation: elevation ?? 3.0,
            minimumSize: shrink ? null : const Size.fromHeight(53.0),
            padding: padding ?? const EdgeInsets.all(10.0),
            backgroundColor: onPressed == null
                ? Colors.grey
                : (backgroundColor ?? AppColors.secondColor),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? BorderRadius.circular(6.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
  );
}

class _Button extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final bool isBusy;
  final bool applyHomeNotch;

  const _Button({
    Key? key,
    this.margin,
    this.isBusy = false,
    required this.child,
    this.applyHomeNotch = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsets buttonMargin = margin ?? EdgeInsets.zero;
    if (applyHomeNotch) {
      final data = MediaQuery.of(context);
      buttonMargin = buttonMargin.copyWith(
        bottom: buttonMargin.bottom + data.padding.bottom,
      );
    }
    return Padding(
      padding: buttonMargin,
      child: isBusy ? const AppLoader() : child,
    );
  }
}
