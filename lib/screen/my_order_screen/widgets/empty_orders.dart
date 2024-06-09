import 'package:arobisca_online_store_app/screen/product_cart_screen/cart_screen.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:flutter/material.dart';

class EmptyOrders extends StatelessWidget {
  const EmptyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Image.asset('assets/images/empty_order.png'),
            ),
          ),
          const SizedBox(height: 30), // Add some spacing
          const Text(
            "You have not Placed any Order(s) Yet",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: Tsizes.spaceBtwItems,),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (content) => const CartScreen())
                    );
                },
                child: const Text("Place Your First Order !", style: TextStyle(color: Colors.black),)),
          )
        ],
      ),
    );
  }
}
