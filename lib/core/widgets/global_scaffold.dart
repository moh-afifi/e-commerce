import 'package:flutter/material.dart';

class GlobalScaffold extends StatelessWidget {
  const GlobalScaffold({
    Key? key,
    this.appBar,
    required this.body,
    this.resizeToAvoidBottomInset,
    this.bottomNavigationBar,
    this.backgroundColor,
  }) : super(key: key);
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
