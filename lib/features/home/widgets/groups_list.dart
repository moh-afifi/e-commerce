import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/categories/providers/category_provider.dart';
import 'package:wssal/features/categories/widgets/group_card.dart';

class GroupsList extends StatelessWidget {
  const GroupsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoriesProvider>(
      builder: (_, provider, __) {
        if (provider.loading) return const AppLoader();
        if (provider.error != null) return const ErrorView();
        final groupsList = provider.groupsList;
        return groupsList.isEmpty
            ? const EmptyView()
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                padding: const EdgeInsets.all(15),
                itemCount: groupsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GroupCard(
                    group: groupsList[index],
                  );
                },
              );
      },
    );
  }
}

// SizedBox(
// height: 150,
// child: ListView.separated(
// padding: const EdgeInsets.symmetric(horizontal: 15),
// itemCount: groupsList.length,
// scrollDirection: Axis.horizontal,
// itemBuilder: (context, index) {
// return GroupCard(
// group: groupsList[index],
// );
// },
// separatorBuilder: (BuildContext context, int index) {
// return const SizedBox(
// width: 20,
// );
// },
// ),
// )
