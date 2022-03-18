import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apis/userSecureStorage.dart';

class UserProfileController extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var nicknameController = TextEditingController();
  var email = '';
  var birthday = '';
  var gender = '';

  var validate = true;

  @override
  void onInit() {
    super.onInit();
    UserSecureStorage.getFirstn().then((value) {
      firstNameController.text = value.toString();
    });

    UserSecureStorage.getLastn().then((value) {
      lastNameController.text = value.toString();
    });

    UserSecureStorage.getUsern().then((value) {
      nicknameController.text = value.toString();
    });

    UserSecureStorage.getEmail().then((value) {
      email = value.toString();
    });

    UserSecureStorage.getBirthday().then((value) {
      birthday = value.toString();
    });

    UserSecureStorage.getGender().then((value) {
      gender = value == 'M'
          ? 'Male'
          : value == 'F'
              ? 'Female'
              : 'Prefer not to say';
    });

    firstNameController.addListener(() {
      print(firstNameController.value.text);
      validate = firstNameController.value.text.isNotEmpty;
      update();
    });
    lastNameController.addListener(() {
      print(lastNameController.value.text);
      validate = lastNameController.value.text.isNotEmpty;
      update();
    });
    nicknameController.addListener(() {
      print(nicknameController.value.text);
      validate = nicknameController.value.text.isNotEmpty;
      update();
    });
  }
}
