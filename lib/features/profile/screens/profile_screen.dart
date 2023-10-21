import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/providers/user_provider.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';

import '../../../core/utils/color_utils.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().userModel;
    return  GlobalScaffold(
      appBar: const GlobalAppBar(title: "الملف الشخصي"),
      body: Column(
        children: [
          CircleAvatar(
            radius: 100.0,
            backgroundImage: NetworkImage(user?.imageUrl ?? ''),
            backgroundColor: AppColors.primaryColor.withOpacity(0.7),
          ),
          const SizedBox(
            height: 20,
          ),
          ProfileCard(
            icon: Icons.person,
            label: user?.name ?? '',
          ),
          ProfileCard(
            icon: Icons.phone,
            label: user?.userId ?? '',
          ),
          ProfileCard(
            icon: Icons.location_on_outlined,
            label: user?.address ?? '',
          ),
          ProfileCard(
            icon: Icons.home_work_outlined,
            label: user?.facilityName ?? '',
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
