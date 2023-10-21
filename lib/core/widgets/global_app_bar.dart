import 'package:flutter/material.dart';
import 'package:wssal/features/search/screens/search_screen.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlobalAppBar({
    Key? key,
    required this.title,
    this.showBackButton = true,
    this.showSearchButton = true,
    this.actions,
  }) : super(key: key);
  final String title;
  final bool showBackButton;
  final bool showSearchButton;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      centerTitle: true,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions ?? (showSearchButton
              ? [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ]
              : null),
      leading: showBackButton
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            )
          : null,
    );
  }
}
