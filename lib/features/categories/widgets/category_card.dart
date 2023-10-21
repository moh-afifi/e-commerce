import 'package:flutter/material.dart';
import 'package:wssal/core/widgets/net_image.dart';
import 'package:wssal/features/categories/data/models/categories_model.dart';
import 'package:wssal/features/categories/screens/category_products_screen.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key, required this.category}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return CategoryProductsScreen(
              category: category,
            );
          },
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 7,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 80,
                width: 80,
                child: NetImage(category.image ?? ''),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              category.label ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
