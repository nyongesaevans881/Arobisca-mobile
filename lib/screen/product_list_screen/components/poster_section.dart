import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/utility/app_data.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/data/data_provider.dart';

class PosterSection extends StatefulWidget {
  const PosterSection({super.key});

  @override
  _PosterSectionState createState() => _PosterSectionState();
}

class _PosterSectionState extends State<PosterSection> {
  int carouselCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (context, dataProvider, child) {
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1,
              onPageChanged: (index, _) {
                setState(() {
                  carouselCurrentIndex = index;
                });
              },
            ),
            items: dataProvider.posters.map((poster) {
              int index = dataProvider.posters.indexOf(poster);
              return Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: AppData.randomPosterBgColors[index % AppData.randomPosterBgColors.length],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    '${dataProvider.posters[index].imageUrl}',
                    height: 125,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null, // Progress indicator.
                        ),
                      );
                    },
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Icon(Icons.error, color: Colors.red);
                    },
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: Tsizes.spaceBtwInputFields,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(dataProvider.posters.length, (index) {
              return Container(
                width: 20,
                height: 5,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: carouselCurrentIndex == index
                      ? AppColor.darkGreen
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(100),
                ),
              );
            }),
          ),
        ],
      );
    });
  }
}
