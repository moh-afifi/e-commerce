import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('لا يوجد بيانات للعرض'),
    );
  }
}
