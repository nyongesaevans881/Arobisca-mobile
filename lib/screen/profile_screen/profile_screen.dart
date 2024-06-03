import 'package:arobisca_online_store_app/screen/authentication/login_screen/login_screen.dart';
import 'package:arobisca_online_store_app/screen/my_address_screen/my_address_screen.dart';
import 'package:arobisca_online_store_app/screen/my_order_screen/my_order_screen.dart';
import 'package:arobisca_online_store_app/screen/product_cart_screen/cart_screen.dart';
import 'package:arobisca_online_store_app/screen/product_favorite_screen/favorite_screen.dart';
import 'package:arobisca_online_store_app/screen/product_list_screen/components/custom_app_bar.dart';
import 'package:arobisca_online_store_app/screen/product_list_screen/product_list_screen.dart';
import 'package:arobisca_online_store_app/utility/animations/open_container_wrapper.dart';
import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/utility/common/image_strings.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/extensions.dart';
import 'package:arobisca_online_store_app/widget/custom_shapes/curved_edges.dart';
import 'package:arobisca_online_store_app/widget/navigation_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: TCustomCurvedEdges(),
              child: Container(
                height: 215,
                width: double.infinity,
                color: AppColor.coffeeColor,
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: [
                    const Positioned(
                        top: -150, right: -250, child: TCircularContainer()),
                    const Positioned(
                        top: 100, right: -300, child: TCircularContainer()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBar(
                          automaticallyImplyLeading: false,
                          centerTitle: false,
                          title: const Text(
                            "My Account",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),

                        const SizedBox(
                          height: Tsizes.spaceBtwInputFields,
                        ),

                        //----- User Profile Card
                        ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                TImages.profile,
                                // fit: ,
                              ),
                            ),
                          ),
                          title: Text(
                            '${context.userProvider.getLoginUsr()?.username}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          subtitle: Text(
                            '${context.userProvider.getLoginUsr()?.email}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.edit,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: OpenContainerWrapper(
                nextScreen: MyOrderScreen(),
                child: NavigationTile(
                  icon: Icons.list,
                  title: 'My Orders',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: OpenContainerWrapper(
                nextScreen: MyAddressPage(),
                child: NavigationTile(
                  icon: Icons.location_on,
                  title: 'My Addresses',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: OpenContainerWrapper(
                nextScreen: CartScreen(),
                child: NavigationTile(
                  icon: Iconsax.shopping_cart,
                  title: 'My Cart',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: OpenContainerWrapper(
                nextScreen: FavoriteScreen(),
                child: NavigationTile(
                  icon: Iconsax.heart,
                  title: 'Favorites',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.darkGreen,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () {
                  context.userProvider.logOutUser();
                  Get.offAll(const LoginScreen());
                },
                child: const Text('Logout', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
