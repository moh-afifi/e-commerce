import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key, required this.description})
      : super(key: key);
  final String? description;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: description != null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "تفاصيل المنتج",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            description ?? '',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
