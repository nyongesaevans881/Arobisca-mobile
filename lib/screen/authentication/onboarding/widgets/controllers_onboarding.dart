import 'package:arobisca_online_store_app/screen/authentication/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  //Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  //Update Current Index When Page Scrolls
  void updatePageIndicator(index) => currentPageIndex = index;

  //Jump to Specific dot selected Page
  void dotNavigationCick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);
  }

  //update current index and jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2) {
      Get.offAll(const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

    //update current index and jump to last page
    void skipPage() {
      currentPageIndex.value = 2;
      pageController.jumpToPage(2);
    }
}
