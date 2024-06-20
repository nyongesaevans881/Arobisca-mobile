import 'package:arobisca_online_store_app/utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
        SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.coffeeColor, // Set status bar color to black
      statusBarIconBrightness: Brightness.light, // Set text/icons to white
    ));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'If you have any questions or need assistance, please feel free to contact us. Our support team is here to help you with any issues or inquiries you may have.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),

            // FAQ Section
            _buildSectionTitle('Frequently Asked Questions (FAQ)'),
            _buildFAQItem(
              'How do I reset my password?',
              const Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text:
                          'To reset your password, go to the login page and click on ',
                      style: TextStyle(fontSize: 16)),
                  TextSpan(
                      text: '"Forgot Password"',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.darkGreen,
                        color: AppColor.darkGreen,
                      )),
                  TextSpan(
                      text: ' Follow the instructions to reset your password.',
                      style: TextStyle(fontSize: 16))
                ]),
              ),
            ),
            _buildFAQItem(
              'How do I contact customer support?',
              const Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: 'You can contact customer support via email at ',
                      style: TextStyle(fontSize: 16)),
                  TextSpan(
                      text: 'support@arobiscagroup.com',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.darkGreen,
                        color: AppColor.darkGreen,
                      )),
                  TextSpan(
                      text: ' or call us at ', style: TextStyle(fontSize: 16)),
                  TextSpan(
                      text: '(254) 781 726 674.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.darkGreen,
                        color: AppColor.darkGreen,
                      )),
                ]),
              ),
            ),
            _buildFAQItem(
              'How can I track my order(s)?',
              const Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: 'Track your Order(s) through the ',
                      style: TextStyle(fontSize: 16)),
                  TextSpan(
                      text: '"My Orders"',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColor.darkGreen,
                        color: AppColor.darkGreen,
                      )),
                  TextSpan(
                      text:
                          ' Screen in the profile tab. We will send you a notification if the status changes.',
                      style: TextStyle(fontSize: 16))
                ]),
              ),
            ),

            const SizedBox(height: 16.0),

            // Contact Us Section
            _buildSectionTitle('Contact Us'),
            _buildContactItem(
                Icons.email, 'Email', 'support@arobiscagroup.com'),
            _buildContactItem(Icons.phone, 'Phone', '(254) 781 726 674'),
            _buildContactItem(
                Iconsax.global, 'Website', 'https://arobiscagroup.com/'),
            const SizedBox(height: 16.0),

            // Feedback Section
            _buildSectionTitle('Feedback'),
            const Text(
              'We value your feedback! If you have any suggestions or comments, please let us know.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to feedback form
              },
              child: const Text(
                'Submit Feedback',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Methods to Build Sections
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, Widget answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
          answer,
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 28, color: AppColor.darkGreen,),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                detail,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
