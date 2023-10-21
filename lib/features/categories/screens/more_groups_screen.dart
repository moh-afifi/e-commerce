import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/categories/providers/category_provider.dart';
import 'package:wssal/features/categories/widgets/group_card.dart';

class MoreGroupsScreen extends StatelessWidget {
  const MoreGroupsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsList = context.read<CategoriesProvider>().groupsList;
    return  GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "المجموعات الرئيسية",
        showBackButton: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: groupsList.length,
        itemBuilder: (BuildContext context, int index) {
          return GroupCard(
            group: groupsList[index],
          );
        },
      ),
      bottomNavigationBar: const GlobalBottomBar(
        currentIndex: -1,
        popToRoot: true,
      ),
    );
  }
}
