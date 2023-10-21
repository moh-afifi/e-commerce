import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/auth/register/providers/register_provider.dart';

class ImageView extends StatelessWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerProvider = context.read<RegisterProvider>();
    return Selector<RegisterProvider, XFile?>(
      shouldRebuild: (previous, next) => previous != next,
      selector: (context, provider) => provider.image,
      builder: (context, image, _) {
        return InkWell(
          onTap: () async => registerProvider.pickFile(),
          child: Stack(
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.secondColor,
                  ),
                ),
                child: Center(
                  child: image == null
                      ? const Icon(
                          Icons.photo_library_outlined,
                          color: AppColors.secondColor,
                          size: 60,
                        )
                      : Image.file(File(image.path)),
                ),
              ),
              Visibility(
                visible: image != null,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    onPressed: () => registerProvider.removeFile(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
