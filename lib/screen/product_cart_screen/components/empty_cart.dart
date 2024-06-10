import 'package:arobisca_online_store_app/utility/common/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: SvgPicture.asset(
                TImages.cart,
              ),
              ),
            ),
          ),
          const Text(
            "Empty cart",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )
        ],
      ),
    );
  }
}
