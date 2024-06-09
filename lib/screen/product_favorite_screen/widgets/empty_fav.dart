import 'package:arobisca_online_store_app/screen/home_screen.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyFav extends StatelessWidget {
  const EmptyFav({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Image.asset('assets/images/favorite.png'),
          ),
        ),
        const SizedBox(height: 30), // Add some spacing
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
