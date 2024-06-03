
import 'package:arobisca_online_store_app/screen/product_cart_screen/provider/cart_provider.dart';
import 'package:arobisca_online_store_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widget/custom_search_bar.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to Arobisca.!',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '${context.userProvider.getLoginUsr()?.username}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20,),

              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  final cartitems = cartProvider.myCartItems.length;

                  return Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          height: 18,
                          width: 18,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Text(
                              '$cartitems',
                              style:
                                  const TextStyle(fontSize: 10, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ]),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomSearchBar(
                    controller: TextEditingController(),
                    onChanged: (val) {
                      // context.dataProvider.filterProducts(val);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
