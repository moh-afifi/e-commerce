import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/categories/data/models/categories_model.dart';
import 'package:wssal/features/categories/providers/category_provider.dart';
import 'package:wssal/features/categories/widgets/sub_categoreis_list.dart';
import 'package:wssal/features/product/widgets/product_card.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({Key? key, required this.category})
      : super(key: key);
  final Category category;

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => context
        .read<CategoriesProvider>()
        .getCategoryProducts(
            categoryId: widget.category.id ?? "-1", subCategoryId: ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "المنتجات",
        showBackButton: true,
      ),
      body: Column(
        children: [
          if (widget.category.subCategoriesList.length > 1)
            SubCategories(
              subCategoriesList: widget.category.subCategoriesList,
              categoryId: widget.category.id ?? '-1',
            ),
          Expanded(
            child: Consumer<CategoriesProvider>(
              builder: (_, provider, __) {
                if (provider.loadingProducts) return const AppLoader();
                if (provider.errorProducts != null) return const ErrorView();
                return provider.productList.isEmpty
                    ? const EmptyView()
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.65,
                        ),
                        padding: const EdgeInsets.all(15),
                        itemCount: provider.productList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                            product: provider.productList[index],
                            showRemoveButton: false,
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const GlobalBottomBar(
        currentIndex: -1,
        popToRoot: true,
      ),
    );
  }
}
