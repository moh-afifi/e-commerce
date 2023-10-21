import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wssal/core/widgets/global_app_bar.dart';
import 'package:wssal/core/widgets/global_bottom_bar.dart';
import 'package:wssal/core/widgets/global_scaffold.dart';
import 'package:wssal/features/orders/providers/orders_provider.dart';
import 'package:wssal/features/orders/widgets/current_orders.dart';
import 'package:wssal/features/orders/widgets/expired_orders.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<OrdersProvider>().getOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const  GlobalScaffold(
      appBar: GlobalAppBar(title: "الطلبات"),
      body: DefaultTabController(
        length: 2,
        initialIndex: 0,
        animationDuration: Duration(milliseconds: 500),
        child: Column(
          children: [
            TabBar(
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.red,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "الطلبات الحالية"),
                Tab(text: "الطلبات السابقة"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CurrentOrders(),
                  ExpiredOrders(),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: GlobalBottomBar(
        currentIndex: -1,
        popToRoot: true,
      ),
    );
  }
}
