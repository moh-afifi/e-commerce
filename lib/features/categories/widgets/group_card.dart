import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/net_image.dart';
import 'package:wssal/features/categories/widgets/categories_view.dart';

import '../data/models/categories_model.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({Key? key, required this.group}) : super(key: key);
  final Group group;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (group.categoriesList.isNotEmpty) {
          showMaterialModalBottomSheet(
            context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            enableDrag: true,
            builder: (_) =>
                CategoriesView(categoriesList: group.categoriesList),
          );
        } else {
          AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.info,
                  desc: 'لا يوجد بيانات للعرض',
                  btnOkOnPress: () {},
                  btnOkText: 'موافق')
              .show();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.secondColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: NetImage(
                group.image ?? '',
                fit: BoxFit.contain,
              ),
            ),
            Center(
              child: Text(
                group.label ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
