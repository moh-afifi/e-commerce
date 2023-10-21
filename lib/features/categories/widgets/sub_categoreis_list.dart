import 'package:flutter/material.dart';
import 'package:wssal/features/categories/data/models/categories_model.dart';
import 'package:wssal/features/categories/widgets/sub_category_filter.dart';

class SubCategories extends StatelessWidget {
  const SubCategories(
      {Key? key, required this.subCategoriesList, required this.categoryId})
      : super(key: key);
  final List<SubCategory> subCategoriesList;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        scrollDirection: Axis.horizontal,
        children: [
           AllItemsFilter(categoryId: categoryId),
          ...List.generate(
            subCategoriesList.length,
            (index) => SubCategoryFilter(
              categoryId: categoryId,
              subCategory: subCategoriesList[index],
            ),
          ),
        ],
      ),
    );
  }
}
