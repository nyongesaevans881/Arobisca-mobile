

import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:flutter/material.dart';


class TermsConditionsCheckbox extends StatelessWidget {
  const TermsConditionsCheckbox({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child:
                Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(
          width: Tsizes.spaceBtwItems,
        ),
        const SizedBox(
          height: Tsizes.spaceBtwSections,
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(
                text: '${TTexts.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
              text: TTexts.privacyPolicy,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(
                      color: AppColor.darkGreen,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.darkGreen),
            ),
            TextSpan(
                text: ' and ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
              text: 'T&Cs',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .apply(
                      color: AppColor.darkGreen,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.darkGreen),
            ),
          ]),
        ),
      ],
    );
  }
}
