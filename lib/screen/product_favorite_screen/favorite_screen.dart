import 'package:arobisca_online_store_app/screen/product_cart_screen/cart_screen.dart';
import 'package:arobisca_online_store_app/screen/product_cart_screen/provider/cart_provider.dart';
import 'package:arobisca_online_store_app/screen/product_favorite_screen/widgets/empty_fav.dart';
import 'package:arobisca_online_store_app/screen/product_list_screen/components/poster_section.dart';
import 'package:arobisca_online_store_app/utility/extensions.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'provider/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/product_grid_view.dart';
import '../../utility/app_color.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.coffeeColor, // Set status bar color to black
      statusBarIconBrightness: Brightness.light, // Set text/icons to white
    ));

    Future.delayed(Duration.zero, () {
      context.favoriteProvider.loadFavoriteItems();
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 18),
          child: AppBar(
            title:
                Padding(
                  padding: const EdgeInsets.only(top: 7),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                const Text(
                  "Favorites",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkGreen),
                                ),
                                Consumer<CartProvider>(
                  builder: (context, cartProvider, child) {
                    final cartitems = cartProvider.myCartItems.length;
                            
                    return Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartScreen()));
                          },
                          icon: const Icon(
                            Iconsax.shopping_bag,
                            color: Colors.black,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                color: AppColor.darkGreen.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(100)),
                            child: Center(
                              child: Text(
                                '$cartitems',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                                ),
                              ]),
                ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Consumer<FavoriteProvider>(
                    builder: (context, favoriteProvider, child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          favoriteProvider.favoriteProduct.isEmpty
                              ? const EmptyFav()
                              : ProductGridView(
                                  items: favoriteProvider.favoriteProduct,
                                )
                        ],
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Hello There,",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Text(
                  "Whats New in Arobisca.?",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: PosterSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
