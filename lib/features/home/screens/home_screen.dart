import 'package:flutter/material.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/best_seller/screens/more_best_seller_screen.dart';
import 'package:wssal/features/categories/screens/more_groups_screen.dart';
import 'package:wssal/features/home/widgets/best_seller_list.dart';
import 'package:wssal/features/home/widgets/groups_list.dart';
import 'package:wssal/features/home/widgets/home_header.dart';
import 'package:wssal/features/home/widgets/search_widget.dart';
import 'package:wssal/features/home/widgets/section_title.dart';
import 'package:wssal/features/home/widgets/vendors_list.dart';
import 'package:wssal/features/vendors/screens/more_vendors_screen.dart';

import '../../offers/widgets/offers_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlobalScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              SearchWidget(),
              OffersSlider(),
              SectionTitle(
                title: "الشركاء",
                routeWidget: MoreVendorsScreens(),
              ),
              VendorsList(),
              SectionTitle(
                title: "المجموعات الرئيسية",
                routeWidget: MoreGroupsScreen(),
              ),
              GroupsList(),
              SectionTitle(
                title: "الأكثر مبيعاً",
                routeWidget: MoreBestSellerScreen(),
              ),
              BestSellerList(),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
