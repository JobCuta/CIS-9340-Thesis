import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apis/userSecureStorage.dart';

class UserProfileController extends GetxController {
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var nicknameController = TextEditingController();
  var birthdayController = TextEditingController();
  var email = '';
  var gender = '';
  var anon = '';
  var validate = true;
  
  @override
  void onInit() {
    super.onInit();
    resetAllValues();
    firstNameController.addListener(() {
      validate = firstNameController.value.text.isNotEmpty;
      update();
    });
    lastNameController.addListener(() {
      validate = lastNameController.value.text.isNotEmpty;
      update();
    });
    nicknameController.addListener(() {
      validate = nicknameController.value.text.isNotEmpty;
      update();
    });
    birthdayController.addListener(() {
      validate = birthdayController.value.text.isNotEmpty;
      update();
    });
  }

  void resetAllValues() {
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
      birthdayController.text = value.toString();
    });

    UserSecureStorage.getGender().then((value) {
      gender = value == 'M'
          ? 'Male'
          : value == 'F'
              ? 'Female'
              : 'Rather not say...';
    });
  }

  void updateValues() {
    //needs api call to actually update the users details in the backend.
    UserSecureStorage.setLoginDetails(
        email,
        nicknameController.text,
        firstNameController.text,
        lastNameController.text,
        birthdayController.text,
        gender,
        anon);
  }
}
