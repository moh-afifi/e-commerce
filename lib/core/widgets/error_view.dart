import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key,  this.error}) : super(key: key);
  final String? error;

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'حدث خطأ في البيانات، الرجاء المحاولة مرة أخرى',
        style: TextStyle(
          color: Colors.red,
        ),
      ),
    );
  }
}
