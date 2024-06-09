import 'package:arobisca_online_store_app/screen/product_by_category_screen/provider/product_by_category_provider';
import 'package:arobisca_online_store_app/screen/product_cart_screen/cart_screen.dart';
import 'package:arobisca_online_store_app/screen/product_cart_screen/provider/cart_provider.dart';
import 'package:arobisca_online_store_app/utility/extensions.dart';
import 'package:iconsax/iconsax.dart';
import '../../models/category.dart';
import '../../models/sub_category.dart';
import '../../utility/app_color.dart';
import '../../widget/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widget/horizondal_list.dart';
import '../../widget/product_grid_view.dart';

class ProductByCategoryScreen extends StatelessWidget {
  final Category selectedCategory;

  const ProductByCategoryScreen({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      context.proByCProvider
          .filterInitialProductAndSubCategory(selectedCategory);
    });
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${selectedCategory.name}",
                      style: const TextStyle(
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
                                        builder: (context) =>
                                            const CartScreen()));
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
              expandedHeight: 190.0,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  var top = constraints.biggest.height -
                      MediaQuery.of(context).padding.top;
                  return Stack(
                    children: [
                      Positioned(
                        top: top - 145,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Consumer<ProductByCategoryProvider>(
                              builder: (context, proByCatProvider, child) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: HorizontalList(
                                    items: proByCatProvider.subCategories,
                                    itemToString: (SubCategory? val) =>
                                        val?.name ?? '',
                                    selected:
                                        proByCatProvider.mySelectedSubCategory,
                                    onSelect: (val) {
                                      // if (val != null) {
                                      //   context.proByCProvider.filterProductBySubCategory(val);
                                      // }
                                    },
                                  ),
                                );
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown<String>(
                                    hintText: 'Sort By Price',
                                    items: const ['Low To High', 'High To Low'],
                                    onChanged: (val) {
                                      if (val?.toLowerCase() == 'low to high') {
                                        context.proByCProvider
                                            .sortProducts(ascending: true);
                                      } else {
                                        context.proByCProvider
                                            .sortProducts(ascending: false);
                                      }
                                    },
                                    displayItem: (val) => val,
                                  ),
                                ),
                                Expanded(
                                  child: CustomDropdown<String>(
                                    hintText: 'Sort By Discount',
                                    items: const ['Low To High', 'High To Low'],
                                    onChanged: (val) {
                                      if (val?.toLowerCase() == 'low to high') {
                                        context.proByCProvider
                                            .sortProducts(ascending: true);
                                      } else {
                                        context.proByCProvider
                                            .sortProducts(ascending: false);
                                      }
                                    },
                                    displayItem: (val) => val,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverToBoxAdapter(
                child: Consumer<ProductByCategoryProvider>(
                  builder: (context, proByCaProvider, child) {
                    return ProductGridView(
                      items: proByCaProvider.filteredProduct,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
