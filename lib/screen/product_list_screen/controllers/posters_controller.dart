import 'package:get/get.dart';

class PostersController extends GetxController {
  static PostersController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;

  void UpdatePageIndicator(index){
    carouselCurrentIndex.value = index;
  }
}