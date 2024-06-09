import 'package:arobisca_online_store_app/screen/authentication/login_screen/login_screen.dart';
import 'package:arobisca_online_store_app/utility/common/device_utility.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: Tsizes.defaultSpace,
      child: TextButton(
      onPressed: () {
        Get.to(
          () => const LoginScreen(),
          transition: Transition.rightToLeft,
          duration: const Duration(milliseconds: 500)
          );
      },
      child: const Text("Skip"),
    ));
  }
}