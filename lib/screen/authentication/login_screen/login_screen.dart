import 'package:arobisca_online_store_app/screen/authentication/login_screen/widgets/form_divider.dart';
import 'package:arobisca_online_store_app/screen/authentication/login_screen/widgets/login_form.dart';
import 'package:arobisca_online_store_app/screen/authentication/login_screen/widgets/login_header.dart';
import 'package:arobisca_online_store_app/screen/authentication/login_screen/widgets/social_buttons.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: Tsizes.appBarHeight,
            left: Tsizes.defaultSpace,
            bottom: Tsizes.defaultSpace,
            right: Tsizes.defaultSpace,
          ),
          child: Column(
            children: [
              ///-------- Logo, title, & subTitle
              const TLoginHeader(),

              ///-------- Form
              const TLoginForm(),

              ///-------- Divider
              TFormDividerr(
                dividerText: TTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(
                height: Tsizes.spaceBtwItems,
              ),

              ///---- Footer
              const TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
