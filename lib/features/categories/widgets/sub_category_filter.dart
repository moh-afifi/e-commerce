import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/core/widgets/net_image.dart';
import 'package:wssal/features/categories/data/models/categories_model.dart';
import 'package:wssal/features/categories/providers/category_provider.dart';

class AllItemsFilter extends StatelessWidget {
  const AllItemsFilter({Key? key,required this.categoryId}) : super(key: key);
  final String categoryId;
  @override
  Widget build(BuildContext context) {
    return SubCategoryFilter(
      categoryId: categoryId,
      subCategory: SubCategory(
        image: '',
        label: 'الكل',
        id: "",
      ),
    );
  }
}

class SubCategoryFilter extends StatelessWidget {
  const SubCategoryFilter(
      {Key? key, required this.subCategory, required this.categoryId})
      : super(key: key);
  final SubCategory subCategory;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return Selector<CategoriesProvider, String?>(
      shouldRebuild: (previous, next) => previous != next,
      selector: (context, provider) => provider.selectedSubCategoryId,
      builder: (context, selectedSubCategoryId, _) {
        return InkWell(
          onTap: () => context.read<CategoriesProvider>().getCategoryProducts(
              subCategoryId: subCategory.id ?? '-1', categoryId: categoryId),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedSubCategoryId == subCategory.id
                          ? AppColors.thirdColor
                          : AppColors.primaryColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: NetImage(
                      subCategory.image ?? '',
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  subCategory.label ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    color: selectedSubCategoryId == subCategory.id
                        ? AppColors.thirdColor
                        : AppColors.primaryColor,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
