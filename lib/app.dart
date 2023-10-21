import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/providers/user_provider.dart';
import 'package:wssal/features/address/providers/address_provider.dart';
import 'package:wssal/features/best_seller/providers/best_seller_provider.dart';
import 'package:wssal/features/cart/providers/cart_provider.dart';
import 'package:wssal/features/categories/providers/category_provider.dart';
import 'package:wssal/features/favorites/providers/favorites_provider.dart';
import 'package:wssal/features/offers/providers/offers_provider.dart';
import 'package:wssal/features/orders/providers/orders_provider.dart';
import 'package:wssal/features/root/providers/root_provider.dart';
import 'package:wssal/features/search/providers/search_provider.dart';
import 'package:wssal/features/vendors/providers/vendors_provider.dart';

import 'core/theme/app_theme.dart';
import 'features/splash/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final _navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState? get navigatorKey => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RootProvider>(
          create: (_) => RootProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<OrdersProvider>(
          create: (_) => OrdersProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<OffersProvider>(
          create: (_) => OffersProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (_) => CategoriesProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<VendorProvider>(
          create: (_) => VendorProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<BestSellerProvider>(
          create: (_) => BestSellerProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<FavoriteProvider>(
          create: (_) => FavoriteProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (_) => SearchProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
          lazy: true,
        ),
        ChangeNotifierProvider<AddressProvider>(
          create: (_) => AddressProvider(),
          lazy: true,
        ),

      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'وصل',
          theme: themeData,
          locale: const Locale('ar', 'EG'),
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
