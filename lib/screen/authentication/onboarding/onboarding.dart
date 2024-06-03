import 'package:arobisca_online_store_app/screen/authentication/onboarding/widgets/controllers_onboarding.dart';
import 'package:arobisca_online_store_app/screen/authentication/onboarding/widgets/on_boarding_next_button.dart';
import 'package:arobisca_online_store_app/screen/authentication/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:arobisca_online_store_app/screen/authentication/onboarding/widgets/onboarding_page.dart';
import 'package:arobisca_online_store_app/screen/authentication/onboarding/widgets/onboarding_skip.dart';
import 'package:arobisca_online_store_app/utility/common/image_strings.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: TImages.onBoardingImage1,
                title: TTexts.onboardingTitle1,
                subTitle: TTexts.onboardingTitleMain1,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage2,
                title: TTexts.onboardingTitle2,
                subTitle: TTexts.onboardingTitleMain2,
              ),
              OnBoardingPage(
                image: TImages.onBoardingImage3,
                title: TTexts.onboardingTitle3,
                subTitle: TTexts.onboardingTitleMain3,
              )
            ],
          ),

          //Skip button
          const OnBoardingSkip(),

          //Dot Navigation SmoothPageIndicator
          const OnBoardingDotNavigation(),

          //Circular Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}




