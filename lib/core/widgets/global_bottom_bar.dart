import 'package:badges/badges.dart' as badges;
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/utils/color_utils.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/favorites/providers/favorites_provider.dart';
import 'package:wssal/features/product/data/models/product_model.dart';
import 'package:wssal/features/root/providers/root_provider.dart';

class GlobalBottomBar extends StatelessWidget {
  const GlobalBottomBar(
      {Key? key, required this.currentIndex, this.popToRoot = false})
      : super(key: key);
  final int currentIndex;
  final bool popToRoot;

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      selectedIndex: currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) {
        context.read<RootProvider>().changeIndex(index);
        if (popToRoot) {
          Navigator.of(context).popUntil(ModalRoute.withName("/Root"));
        }
      },
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: SvgPicture.asset(
            "assets/icons/shop_icon.svg",
            color: currentIndex == 0
                ? AppColors.primaryColor
                : AppColors.thirdColor,
          ),
          title: const Text(
            'الرئيسية',
          ),
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.red,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Selector<CartProvider, List<Product>>(
            shouldRebuild: (previous, next) => true,
            selector: (context, provider) => provider.productList,
            builder: (context, productList, _) {
              return badges.Badge(
                badgeContent: Text(
                  '${productList.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
                showBadge: productList.isNotEmpty,
                position: badges.BadgePosition.topStart(start: 15, top: -15),
                child: SvgPicture.asset(
                  "assets/icons/cart_icon.svg",
                  color: currentIndex == 1
                      ? AppColors.primaryColor
                      : AppColors.thirdColor,
                ),
              );
            },
          ),
          title: const Text('السلة'),
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.red,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Selector<FavoriteProvider, List<Product>>(
            shouldRebuild: (previous, next) => true,
            selector: (context, provider) => provider.productList,
            builder: (context, productList, _) {
              return badges.Badge(
                badgeContent: Text(
                  '${productList.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                  ),
                ),
                showBadge: productList.isNotEmpty,
                position: badges.BadgePosition.topStart(start: 15, top: -15),
                child: SvgPicture.asset(
                  "assets/icons/favourite_icon.svg",
                  color: currentIndex == 2
                      ? AppColors.primaryColor
                      : AppColors.thirdColor,
                ),
              );
            },
          ),
          title: const Text('المفضلة'),
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.red,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: SvgPicture.asset(
            "assets/icons/promo_icon.svg",
            color: currentIndex == 3
                ? AppColors.primaryColor
                : AppColors.thirdColor,
          ),
          title: const Text('عروض'),
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.red,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: SvgPicture.asset(
            "assets/icons/account_icon.svg",
            color: currentIndex == 4
                ? AppColors.primaryColor
                : AppColors.thirdColor,
          ),
          title: const Text('حسابي'),
          activeColor: AppColors.primaryColor,
          inactiveColor: Colors.red,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
