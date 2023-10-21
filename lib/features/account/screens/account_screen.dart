import 'package:flutter/material.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/account/widgets/account_item.dart';
import 'package:wssal/features/account/widgets/logout_button.dart';

import '../data/models/account_item_model.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      appBar: const GlobalAppBar(
        title: "حسابي",
        showBackButton: false,
      ),
      body: Column(
        children: [
          Column(
            children: List.generate(
              accountItems.length,
              (index) => AccountItem(
                label: accountItems[index].label,
                svgPath: accountItems[index].iconPath,
                navigateTo: accountItems[index].navigateTo,
              ),
            ),
          ),
          const Spacer(),
          const LogoutButton(),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
