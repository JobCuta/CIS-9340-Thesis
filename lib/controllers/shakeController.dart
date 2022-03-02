import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ShakeController extends GetxController {
  var screenTitle = 'Shake your phone!'.obs;
  var screenDesc = 'Randomize the first exercise you will do!'.obs;
  var controller = PageController().obs;

  onPageChange(title, desc) {
    screenTitle.value = title;
    screenDesc.value = desc;
  }

  animateTo() {
    if (controller.value.hasClients) {
      controller.value.animateToPage(1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }
}
