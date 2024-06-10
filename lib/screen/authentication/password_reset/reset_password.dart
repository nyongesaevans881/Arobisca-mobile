import 'package:arobisca_online_store_app/screen/authentication/login_screen/login_screen.dart';
import 'package:arobisca_online_store_app/screen/authentication/login_screen/provider/user_provider.dart';
import 'package:arobisca_online_store_app/utility/common/helper_functions.dart';
import 'package:arobisca_online_store_app/utility/common/image_strings.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  bool _isLoading = false;

  Future<void> _resendLink() async {
    setState(() {
      _isLoading = true;
    });

    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final response = await authProvider.resetPassword(widget.email);

    setState(() {
      _isLoading = false;
    });

    if (response == null) {
      // Handle success (show snackbar or dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent to ${widget.email}')),
      );
    } else {
      // Handle error (show snackbar or dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Tsizes.defaultSpace),
          child: Column(
            children: [
              //------- Image with 60% of screen width
              SvgPicture.asset(
                TImages.onSucesss,
                width: THelperFunctions.screenWidth() * 0.6,
              ),

              const SizedBox(
                height: Tsizes.spaceBtwSections,
              ),

              // Title and Subtitle
              const Text(
                TTexts.changeYourPasswordTitle,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: Tsizes.spaceBtwItems,
              ),

              Text(TTexts.changeYourPasswordSubtitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: Tsizes.spaceBtwSections,),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()) 
                    );
                  },
                  child: const Text(TTexts.done, style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: Tsizes.spaceBtwSections,),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _isLoading ? null : _resendLink,
                  child: _isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(TTexts.resendEmail),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
