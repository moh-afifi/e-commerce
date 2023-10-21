import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NetImage extends CachedNetworkImage {
  NetImage(
    String src, {
    Key? key,
    String? url,
    double? height,
    double? width,
    double? errorHeight,
    double? errorWidth,
    BoxFit? fit,
    Color? color,
    String? errorImageSVGPath,
    BoxFit? errorImageFit,
    ImageWidgetBuilder? imageBuilder,
  }) : super(
          key: key,
          imageUrl: src,
          width: width,
          imageBuilder: imageBuilder,
          height: height,
          fit: fit ?? BoxFit.cover,
          color: color,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.transparent,
            highlightColor: Colors.white,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            errorImageSVGPath ?? 'assets/images/logo.png',
            height: errorHeight ?? 70,
            width: errorWidth ?? 70,
            fit: BoxFit.contain,
          ),
        );
}
