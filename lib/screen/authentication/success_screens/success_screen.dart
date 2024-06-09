import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/utility/common/helper_functions.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessScreen extends StatelessWidget {
  final String image, title, subtitle;
  final bool showLoginText;
  final VoidCallback onPressed;

  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onPressed, 
      this.showLoginText = true,
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                children: [
                  //Image
                  SvgPicture.asset(
                    image,
                    width: THelperFunctions.screenWidth() * 0.6,
                  ),
                  const SizedBox(
                    height: Tsizes.spaceBtwSections,
                  ),

                  //Title and Subtitle
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: Tsizes.spaceBtwItems,
                  ),

                  Text(
                    subtitle,
                    style: const TextStyle(fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: Tsizes.spaceBtwSections,
                  ),
                  Text(
                    showLoginText ? TTexts.yourAccountCreatedNotice : '',
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: Tsizes.spaceBtwInputFields,
                  ),

                  //Buttons
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: const Text(
                        TTexts.continueText,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
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
