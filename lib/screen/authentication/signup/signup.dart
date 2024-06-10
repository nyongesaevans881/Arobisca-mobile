import 'package:arobisca_online_store_app/screen/authentication/login_screen/widgets/form_divider.dart';
import 'package:arobisca_online_store_app/screen/authentication/login_screen/widgets/social_buttons.dart';
import 'package:arobisca_online_store_app/screen/authentication/signup/widgets/signupform.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Tsizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///---------- Title
              Text(TTexts.signUpTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: Tsizes.spaceBtwSections,),

              ///---------- Form
              const SignUpForm(),

              const SizedBox(height: Tsizes.spaceBtwItems,),
              //--------- Form Divider
              const TFormDividerr(dividerText: TTexts.orSignUpWith),
               const SizedBox(height: Tsizes.spaceBtwItems,),

              //--------- Social Buttons
              const TSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
