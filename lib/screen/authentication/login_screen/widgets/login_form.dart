import 'package:arobisca_online_store_app/screen/authentication/login_screen/provider/user_provider.dart';
import 'package:arobisca_online_store_app/screen/authentication/password_reset/forgot_password_method.dart';
import 'package:arobisca_online_store_app/screen/authentication/signup/signup.dart';
import 'package:arobisca_online_store_app/screen/home_screen.dart';
import 'package:arobisca_online_store_app/utility/animations/fade_page_route.dart';
import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:arobisca_online_store_app/utility/common/sizes.dart';
import 'package:arobisca_online_store_app/utility/common/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class TLoginForm extends StatefulWidget {
  const TLoginForm({super.key});

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool isChecked = true;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final email = _emailController.text;
      final password = _passwordController.text;

      // Use the provider to handle login
      final result = await context.read<UserProvider>().login(email, password);

      setState(() {
        _isLoading = false;
      });

      if (result == null) {
        // Login successful, check if user ID exists
        final userId = context.read<UserProvider>().getLoginUsr()?.sId;
        if (userId != null) {
          // Add a delay before navigating
          await Future.delayed(const Duration(seconds: 1));

          // Use custom fade transition
          Navigator.pushReplacement(
            context,
            FadePageRoute(page: const HomeScreen()),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Tsizes.spaceBtwSections),
        child: Column(
          children: [
            //----------- Email
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right),
                labelText: TTexts.email,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(
              height: Tsizes.spaceBtwInputFields,
            ),

            //----------- Password
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: TTexts.password,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: !_isPasswordVisible,
            ),

            const SizedBox(
              height: Tsizes.spaceBtwInputFields,
            ),

            //-------- Remember me & Forget Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///----- Remember me
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        // onChanged callback to toggle the checkbox
                        setState(() {
                          isChecked = value!;
                        });
                      },
                      activeColor: AppColor.darkGreen,
                    ),
                    const Text(TTexts.rememberMe),
                  ],
                ),

                ///------ Forget Password
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPasswordMethodScreen()),
                    );
                  },
                  child: const Text(TTexts.forgetPassword),
                ),  
              ],
            ),

            const SizedBox(
              height: Tsizes.spaceBtwItems,
            ),

            //-------- sign in button
            if (_isLoading)
              const CircularProgressIndicator()
            else
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text(
                    TTexts.signIn,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: Tsizes.spaceBtwItems,
            ),

            // ------- Create account button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  TTexts.createAccount,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
