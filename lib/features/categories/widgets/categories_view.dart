import 'package:flutter/material.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/categories/data/models/categories_model.dart';
import 'package:wssal/features/categories/widgets/category_card.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key, required this.categoriesList})
      : super(key: key);
  final List<Category> categoriesList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 3,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(10.0),
            ), //
          ),
          if (categoriesList.first.parentItemGroup != null)
            Text(
              categoriesList.first.parentItemGroup ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.thirdColor,
                fontSize: 14,
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 15),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: categoriesList[index],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
