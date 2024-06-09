import 'package:arobisca_online_store_app/screen/product_list_screen/components/category_selector.dart';
import 'package:arobisca_online_store_app/screen/product_list_screen/components/custom_app_bar.dart';
import 'package:arobisca_online_store_app/screen/product_list_screen/components/poster_section.dart';
import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/widget/custom_shapes/curved_edges.dart';

import '../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../widget/product_grid_view.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: TCustomCurvedEdges(),
                  child: Container(
                    height: 350,
                    color: AppColor.coffeeColor,
                    padding: const EdgeInsets.all(0),
                    child: Stack(
                      children: [
                        const Positioned(
                            top: -150,
                            right: -250,
                            child: TCircularContainer()),
                        const Positioned(
                            top: 100, right: -300, child: TCircularContainer()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomAppBar(),
                            const Padding(
                              padding: EdgeInsets.only(left: 14),
                              child: Text(
                                "Top categories",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Consumer<DataProvider>(
                              builder: (context, dataProvider, child) {
                                return CategorySelector(
                                  categories: dataProvider.categories,
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Hello There,",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Whats New in Arobisca.?",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: PosterSection(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Our Products",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Click for Additional Information",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ProductGridView(
                        items: dataProvider.products,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TCircularContainer extends StatelessWidget {
  const TCircularContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 400,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(400),
          color: Colors.white.withOpacity(0.1)),
    );
  }
}
