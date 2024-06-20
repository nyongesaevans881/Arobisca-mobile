import 'package:arobisca_online_store_app/screen/my_order_screen/widgets/empty_orders.dart';
import 'package:arobisca_online_store_app/utility/utility_extension.dart';
import 'package:flutter/services.dart';
import '../../core/data/data_provider.dart';
import '../../utility/app_color.dart';
import '../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/order_tile.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.coffeeColor, // Set status bar color to black
      statusBarIconBrightness: Brightness.light, // Set text/icons to white
    ));
    context.dataProvider.getAllOrderByUser(context.userProvider.getLoginUsr());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColor.darkGreen),
        ),
      ),
      body: Consumer<DataProvider>(
        builder: (context, provider, child) {
          return context.dataProvider.orders.isEmpty
              ? const EmptyOrders()
              : ListView.builder(
                  itemCount: context.dataProvider.orders.length,
                  itemBuilder: (context, index) {
                    final order = context.dataProvider.orders[index];
                    return OrderTile(
                      paymentMethod: order.paymentMethod ?? '',
                      items:
                          '${(order.items?.safeElementAt(0)?.productName ?? '')} & ${order.items!.length - 1} other Items',
                      date: order.orderDate ?? '',
                      status: order.orderStatus ?? 'pending',
                      onTap: () {},
                    );
                  },
                );
        },
      ),
    );
  }
}
