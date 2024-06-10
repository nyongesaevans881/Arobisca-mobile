import 'package:arobisca_online_store_app/screen/home_screen.dart';
import 'package:arobisca_online_store_app/utility/common/image_strings.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyFav extends StatelessWidget {
  const EmptyFav({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: SizedBox(
            height: 300,
            child: SvgPicture.asset(
                TImages.fav,
              ),
          ),
        ),
        // const SizedBox(height: 30), // Add some spacing
        const Text(
          "Empty ❤ List",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(height: Tsizes.spaceBtwItems,),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (content) => const HomeScreen())
                  );
              },
              child: const Text("Let's Fill it !", style: TextStyle(color: Colors.black),)),
        )
      ],
    );
  }
}
