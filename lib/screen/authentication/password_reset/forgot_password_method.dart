import 'package:arobisca_online_store_app/screen/authentication/password_reset/forgot_password.dart';
import 'package:flutter/material.dart';

class ForgotPasswordMethodScreen extends StatelessWidget {
  const ForgotPasswordMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MAKE SELECTION',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select which contact detail should we use to reset your password?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                // Navigate to placeholder screen for SMS option
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgetPassword()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.sms, size: 40),
                    SizedBox(width: 16),
                    Text(
                      'via sms:\n+923332562233',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to placeholder screen for Email option
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ForgetPassword()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.email, size: 40),
                    SizedBox(width: 16),
                    Text(
                      'via mail:\nsupport@gmail.com',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

