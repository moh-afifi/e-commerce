import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/empty_view.dart';
import 'package:wssal/core/widgets/error_view.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/core/widgets/loading.dart';
import 'package:wssal/features/notifications/providers/notification_provider.dart';
import 'package:wssal/features/notifications/widgets/notification_card.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      appBar: const GlobalAppBar(title: "الإشعارات"),
      body: ChangeNotifierProvider(
        create: (_) => NotificationProvider(),
        child: Consumer<NotificationProvider>(
          builder: (_, provider, __) {
            if (provider.loading) return const AppLoader();
            if (provider.error != null) return const ErrorView();
            final notificationList = provider.notificationList;
            return notificationList.isEmpty
                ? const EmptyView()
                : ListView.builder(
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      return NotificationCard(
                        notification: notificationList[index],
                      );
                    },
                  );
          },
        ),
      ),
      bottomNavigationBar: const GlobalBottomBar(
        currentIndex: -1,
        popToRoot: true,
      ),
    );
  }
}
