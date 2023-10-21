import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/app_utils.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/support/providers/support_provider.dart';
import 'package:wssal/features/support/screens/message_screen.dart';

import '../widgets/support_card.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GlobalScaffold(
      appBar: const GlobalAppBar(title: "الدعم"),
      body: Column(
        children: [
          Image.asset(
            'assets/images/support.jpg',
            height: 300,
          ),
          SupportCard(
            icon: Icons.phone_callback,
            label: 'الاتصال بالهاتف',
            onTap: () => AppUtils.makePhoneCall(),
          ),
          SupportCard(
            icon: FontAwesomeIcons.whatsapp,
            label: 'الواتس اب',
            onTap: () => AppUtils.openWhatsapp(),
          ),
          SupportCard(
            icon: Icons.message_outlined,
            label: 'شكوى أو اقتراح',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return ChangeNotifierProvider(
                    create: (_) => SupportProvider(),
                    child: const MessageScreen(),
                  );
                },
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
      bottomNavigationBar: const GlobalBottomBar(
        currentIndex: -1,
        popToRoot: true,
      ),
    );
  }
}
