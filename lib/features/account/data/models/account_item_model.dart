import 'package:flutter/cupertino.dart';
import 'package:wssal/features/account/screens/privacy_policy_screen.dart';
import 'package:wssal/features/address/screens/addresses_screen.dart';
import 'package:wssal/features/notifications/screens/notification_screen.dart';
import 'package:wssal/features/orders/screens/orders_screen.dart';
import 'package:wssal/features/profile/screens/profile_screen.dart';
import 'package:wssal/features/support/screens/support_screen.dart';

class AccountItemModel {
  final String label;
  final String iconPath;
  final Widget navigateTo;

  AccountItemModel(this.label, this.iconPath, this.navigateTo);
}

List<AccountItemModel> accountItems = [
  AccountItemModel(
    "الدعم",
    "assets/icons/help_icon.svg",
    const SupportScreen(),
  ),
  AccountItemModel(
    "الطلبات",
    "assets/icons/orders_icon.svg",
    const OrdersScreen(),
  ),
  // AccountItemModel(
  //   "المحفظة",
  //   "assets/icons/wallet.svg",
  //   const WalletScreen(),
  // ),
  AccountItemModel(
    "العناوين",
    "assets/icons/delivery_icon.svg",
    const AddressesScreen(),
  ),
  AccountItemModel(
    "الإشعارات",
    "assets/icons/notification_icon.svg",
    const NotificationScreen(),
  ),
  AccountItemModel(
    "الملف الشخصي",
    "assets/icons/details_icon.svg",
    const ProfileScreen(),
  ),
  AccountItemModel(
    "سياسة الخصوصية",
    "assets/icons/about_icon.svg",
    const PrivacyPolicyScreen(),
  ),
];
