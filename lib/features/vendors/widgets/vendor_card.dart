import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/net_image.dart';
import 'package:wssal/features/product/data/models/product_type_enum.dart';
import 'package:wssal/features/product/screens/all_products_screen.dart';
import 'package:wssal/features/vendors/data/models/vendors_model.dart';

class VendorCard extends StatelessWidget {
  const VendorCard({Key? key, required this.vendor}) : super(key: key);
  final Vendor vendor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return  AllProductsScreens(
                productType: ProductTypeEnum.vendor,
                vendorId: vendor.id,
              );
            },
          ),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primaryColor,
              ),
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: NetImage(
                vendor.image ?? '',
                width: 100,
                height: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            vendor.label ?? '',
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.thirdColor,
            ),
          )
        ],
      ),
    );
  }
}
