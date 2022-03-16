import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  var firstNameController = TextEditingController(text: "Joe");
  var lastNameController = TextEditingController(text: "Apples");
  var nicknameController = TextEditingController(text: "Appley");
  var validate = true;

  @override
  void onInit() {
    firstNameController.addListener(() {
      print(firstNameController.value);
      validate = firstNameController.value.text.isNotEmpty;
      update();
    });
    lastNameController.addListener(() {
      print(lastNameController.value);
      validate = lastNameController.value.text.isNotEmpty;
      update();
    });
    nicknameController.addListener(() {
      print(nicknameController.value);
      validate = nicknameController.value.text.isNotEmpty;
      update();
    });

    super.onInit();
  }
}
