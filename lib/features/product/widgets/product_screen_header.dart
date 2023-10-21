import 'package:flutter/material.dart';
import 'package:wssal/core/widgets/net_image.dart';

class ProductScreenHeader extends StatelessWidget {
  const ProductScreenHeader({Key? key, required this.imagePath,required this.productId})
      : super(key: key);
  final String imagePath;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height /3,
          width: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Hero(
            tag: productId,
            child: NetImage(
              imagePath,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
