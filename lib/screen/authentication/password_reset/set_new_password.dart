import 'package:arobisca_online_store_app/screen/authentication/login_screen/login_screen.dart';
import 'package:arobisca_online_store_app/screen/authentication/login_screen/provider/user_provider.dart';
import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class SetNewPassword extends StatefulWidget {
  final String email;
  final String resetCode;

  const SetNewPassword({Key? key, required this.email, required this.resetCode})
      : super(key: key);

  @override
  _SetNewPasswordState createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  Future<void> _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      final authProvider = Provider.of<UserProvider>(context, listen: false);
      final response = await authProvider.resetPassword(
        widget.email,
        widget.resetCode,
        _passwordController.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });

      if (response == null) {
        // Navigate to ResetPasswordScreen with success response if needed
        Get.off(() => LoginScreen());
      } else {
        // Handle error (show snackbar or dialog)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(Tsizes.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //---------- Headings
                Text(
                  "Set New Password",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: Tsizes.spaceBtwItems),
                Text(
                  "Your Identy has been verified.!\nUse the fields bellow to Set Your New Password.",
                  style: Theme.of(context).textTheme.labelMedium,
                ),

                const SizedBox(height: Tsizes.spaceBtwSections,),

                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: const Icon(Iconsax.direct_right),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: Tsizes.spaceBtwInputFields),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: TTexts.confirmPassword,
                    prefixIcon: const Icon(Iconsax.direct_right),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: Tsizes.spaceBtwSections,),

                //---------- Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _submit,
                    child: _isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.darkGreen),
                            ),
                          )
                        : const Text(
                            TTexts.submit,
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
