import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/account/screens/account_screen.dart';
import 'package:wssal/features/cart/screens/cart_screen.dart';
import 'package:wssal/features/discount_items/screens/discount_screen.dart';
import 'package:wssal/features/favorites/screens/favourite_screen.dart';
import 'package:wssal/features/home/screens/home_screen.dart';
import 'package:wssal/features/root/providers/root_provider.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => checkAppState());
    super.initState();
  }

  Future<void> checkAppState() async {
    await context.read<RootProvider>().checkAppState().then((res) async {
      final isUserActive = res?.isUserActive ?? false;
      final isPriceUpdate = res?.priceUpdate ?? false;
      if (!isUserActive) {
        await AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.info,
          title: 'بانتظار تفعيل الحساب',
          desc: 'يمكنك استخدام التطبيق بعد تفعيل الحساب',
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
        ).show();
      } else if (isPriceUpdate) {
        await AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.info,
          title: 'جاري تحديث الأسعار',
          desc: "الرجاء المحاولة بعد قليل",
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.question,
          desc: 'هل تريد الخروج من التطبيق؟',
          btnOkOnPress: () =>
              SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
          btnOkText: 'موافق',
        ).show();
        return false;
      },
      child: Selector<RootProvider, int>(
        shouldRebuild: (previous, next) => previous != next,
        selector: (context, provider) => provider.currentIndex,
        builder: (context, currentIndex, _) {
          return GlobalScaffold(
            body: Center(
              child: LazyLoadIndexedStack(
                index: currentIndex,
                children: const [
                  HomeScreen(),
                  CartScreen(),
                  FavouriteScreen(),
                  DiscountScreen(),
                  AccountScreen(),
                ],
              ),
            ),
            bottomNavigationBar: GlobalBottomBar(currentIndex: currentIndex),
          );
        },
      ),
    );
  }
}
