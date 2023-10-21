import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/product/widgets/product_card.dart';
import 'package:wssal/features/search/providers/search_provider.dart';

import '../widgets/search_bar_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: GlobalScaffold(
        resizeToAvoidBottomInset: false,
        appBar: const GlobalAppBar(
          title: "البحث",
          showBackButton: true,
          showSearchButton: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SearchBarWidget(),
              Expanded(
                child: Consumer<SearchProvider>(
                  builder: (_, provider, __) {
                    if (provider.loading) return const AppLoader();
                    if (provider.error != null) return const ErrorView();
                    if (provider.productList.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/search.gif'),
                          const EmptyView(),
                          const Spacer(),
                        ],
                      );
                    }
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 15,
                        childAspectRatio: 0.65,
                      ),
                      padding: const EdgeInsets.only(bottom: 15),
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
        ),
        bottomNavigationBar: const GlobalBottomBar(
          currentIndex: -1,
          popToRoot: true,
        ),
      ),
    );
  }
}
