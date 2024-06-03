import 'package:arobisca_online_store_app/screen/product_cart_screen/components/buy_now_bottom_sheet.dart';
import 'package:arobisca_online_store_app/screen/product_cart_screen/components/cart_list_section.dart';
import 'package:arobisca_online_store_app/screen/product_cart_screen/components/empty_cart.dart';
import 'package:arobisca_online_store_app/utility/animations/animated_switcher_wrapper.dart';

import 'provider/cart_provider.dart';
import '../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utility/app_color.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      context.cartProvider.getCartItems();
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColor.darkGreen),
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              cartProvider.myCartItems.isEmpty
                  ? const EmptyCart()
                  : Consumer<CartProvider>(
                      builder: (context, cartProvider, child) {
                        return CartListSection(cartProducts: cartProvider.myCartItems);
                      },
                    ),

              //? total price section
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                    AnimatedSwitcherWrapper(
                      child: Text(
                        "KES. ${context.cartProvider.getCartSubTotal()}",
                        // key: ValueKey<double>(cartProvider.getCartSubTotal()),
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: AppColor.darkGreen,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              //? buy now button
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
                    onPressed: context.cartProvider.myCartItems.isEmpty
                        ? null
                        : () {
                            showCustomBottomSheet(context);
                          },
                    child: const Text("Place Order", style: TextStyle(color: Colors.white)),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
