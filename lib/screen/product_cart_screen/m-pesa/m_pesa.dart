import 'package:arobisca_online_store_app/screen/product_cart_screen/provider/cart_provider.dart';
import 'package:arobisca_online_store_app/utility/animations/animated_switcher_wrapper.dart';
import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:arobisca_online_store_app/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class MPesa extends StatefulWidget {
  final Map<String, dynamic> orderDetails;

  MPesa({required this.orderDetails});

  @override
  _MPesaState createState() => _MPesaState();
}

class _MPesaState extends State<MPesa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> initiateMpesaPayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<CartProvider>().initiateMpesaTransaction(
        context,
        widget.orderDetails,
        _phoneController.text,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Tsizes.defaultSpace),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    TTexts.mpesaTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset('assets/images/arobisca-mpesa.png'),
                  const SizedBox(height: Tsizes.spaceBtwInputFields),
                  const Text.rich(
                    TextSpan(children: [
                      TextSpan(
                          text: '${TTexts.mpesaDesc} ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      TextSpan(
                          text: TTexts.mpesaAction,
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      TextSpan(
                          text: '\n${TTexts.mpesaDesc2} ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                      TextSpan(
                          text: TTexts.mpesaAction2,
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      TextSpan(
                          text: ' With the Total Ammount at Checkout.',
                          style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300
                          )),
                      TextSpan(
                          text: '\n${TTexts.mpesaDesc3}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300)),
                    ]),
                  ),
                  const SizedBox(height: Tsizes.spaceBtwSections),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ),
                        AnimatedSwitcherWrapper(
                          child: Text(
                            "KES. ${context.cartProvider.getGrandTotal()} ",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: AppColor.darkGreen,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: TTexts.mpesaHint,
                      prefixIcon: const Icon(Iconsax.direct_right),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: Tsizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : initiateMpesaPayment,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Pay :  KES. ${context.cartProvider.getGrandTotal()} ',
                              style: const TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
