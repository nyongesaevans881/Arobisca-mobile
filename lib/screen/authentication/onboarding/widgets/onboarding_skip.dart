import 'package:arobisca_online_store_app/screen/authentication/onboarding/widgets/controllers_onboarding.dart';
import 'package:arobisca_online_store_app/utility/common/device_utility.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:flutter/material.dart';


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
      onPressed: () => OnBoardingController.instance.skipPage(),
      child: const Text("Skip"),
    ));
  }
}