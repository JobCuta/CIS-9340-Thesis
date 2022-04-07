// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/ContactDetails.dart';
import 'package:flutter_application_1/apis/hopeBoxHive.dart';
import 'package:flutter_application_1/apis/hopeBoxObject.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HopeBoxController extends GetxController {
  Box box = Hive.box<HopeBox>('hopeBox');
  RxList images = [].obs;
  RxList videos = [].obs;
  RxList recordings = [].obs;
  var contactPerson = ContactDetails(
          pathImage: '',
          firstName: '',
          lastName: '',
          mobileNumber: '',
          message: '')
      .obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void prepareTheObjects() {
    if (box.isEmpty) {
      ContactDetails person = ContactDetails(
          pathImage: '',
          firstName: '',
          lastName: '',
          mobileNumber: '',
          message: '');
      HopeBox hopeBox = HopeBox(
          images: [], videos: [], recordings: [], contactPerson: person);
      box.put('hopebox', hopeBox);
    }
    HopeBox hopeBox = box.get('hopebox');
    images.value = hopeBox.images;
    videos.value = hopeBox.videos;
    recordings.value = hopeBox.recordings;
    contactPerson.value = hopeBox.contactPerson;

    firstNameController.text = hopeBox.contactPerson.getFirstName();
    lastNameController.text = hopeBox.contactPerson.getLastName();
    mobileNumberController.text = hopeBox.contactPerson.getMobileNumber();
    messageController.text = hopeBox.contactPerson.getMessage();

    print('HopeBox');
    print(box.toMap().length);
    checkValues();
    update();
  }

  // Image methods
  void addImage(desc, path) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newImage = HopeBoxObject(
        datetime: DateTime.now(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
        thumbnailPath: '');
    hopeBox.images.insert(0, newImage);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  void updateImage(index, desc, path) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newImage = HopeBoxObject(
        datetime: hopeBox.images[index].getDateTime(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
        thumbnailPath: '');
    hopeBox.images[index] = newImage;
    box.put('hopebox', hopeBox);
    update();
  }

  void updateImageDesc(index, desc) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newImage = HopeBoxObject(
        datetime: hopeBox.images[index].getDateTime(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: hopeBox.images[index].getPath(),
        thumbnailPath: '');
    hopeBox.images[index] = newImage;
    box.put('hopebox', hopeBox);
    update();
  }

  void removeImage(index) {
    HopeBox hopeBox = box.get('hopebox');
    hopeBox.images.removeAt(index);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  // Video methods
  void addVideo(desc, path, thumbnailPath) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newVideo = HopeBoxObject(
        datetime: DateTime.now(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
        thumbnailPath: thumbnailPath);
    hopeBox.videos.insert(0, newVideo);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  void updateVideo(index, desc, path, thumbnailPath) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newVideo = HopeBoxObject(
        datetime: hopeBox.videos[index].getDateTime(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
        thumbnailPath: thumbnailPath);
    hopeBox.videos[index] = newVideo;
    box.put('hopebox', hopeBox);
    update();
  }

  void updateVideoDesc(index, desc) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newVideo = HopeBoxObject(
        datetime: hopeBox.videos[index].getDateTime(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: hopeBox.videos[index].getPath(),
        thumbnailPath: hopeBox.videos[index].getThumbnailPath());
    hopeBox.videos[index] = newVideo;
    box.put('hopebox', hopeBox);
    update();
  }

  void removeVideo(index) {
    HopeBox hopeBox = box.get('hopebox');
    hopeBox.videos.removeAt(index);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  // Recording methods
  void addRecording(desc, path) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newRecording = HopeBoxObject(
        datetime: DateTime.now(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
        thumbnailPath: '');
    hopeBox.recordings.insert(0, newRecording);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  void updateRecording(index, desc, path) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newRecording = HopeBoxObject(
        datetime: hopeBox.recordings[index].getDateTime(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
        thumbnailPath: '');
    hopeBox.recordings[index] = newRecording;
    box.put('hopebox', hopeBox);
    update();
  }

  void updateRecordingDesc(index, desc) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newRecording = HopeBoxObject(
        datetime: hopeBox.recordings[index].getDateTime(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: hopeBox.recordings[index].getPath(),
        thumbnailPath: '');
    hopeBox.recordings[index] = newRecording;
    box.put('hopebox', hopeBox);
    update();
  }

  void removeRecording(index) {
    HopeBox hopeBox = box.get('hopebox');
    hopeBox.recordings.removeAt(index);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  // contact person details methods
  saveContactDetails(path) {
    HopeBox hopeBox = box.get('hopebox');
    ContactDetails newPerson = ContactDetails(
      pathImage: path,
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      mobileNumber: mobileNumberController.text,
      message: messageController.text != ''
          ? messageController.text
          : 'Hey ${firstNameController.text}, I really need your help right now. I feel like I am at risk of harming myself or others. Please contact me as soon as you can.',
    );

    firstNameController.text = newPerson.firstName;
    lastNameController.text = newPerson.lastName;
    mobileNumberController.text = newPerson.mobileNumber;
    if (messageController.text == '') {
      messageController.text = newPerson.message;
    }

    hopeBox.contactPerson = newPerson;
    contactPerson.value = newPerson;
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  updateMessage(message) {
    HopeBox hopeBox = box.get('hopebox');
    ContactDetails newPerson = ContactDetails(
        pathImage: hopeBox.contactPerson.pathImage,
        firstName: hopeBox.contactPerson.firstName,
        lastName: hopeBox.contactPerson.lastName,
        mobileNumber: hopeBox.contactPerson.mobileNumber,
        message: message);
    hopeBox.contactPerson = newPerson;
    box.put('hopebox', hopeBox);
    contactPerson.value = newPerson;
    messageController.text = message;
    checkValues();
    update();
  }

  deleteContactDetails() {
    HopeBox hopeBox = box.get('hopebox');
    ContactDetails newPerson = ContactDetails(
      pathImage: '',
      firstName: '',
      lastName: '',
      mobileNumber: '',
      message: '',
    );
    hopeBox.contactPerson = newPerson;
    contactPerson.value = newPerson;

    firstNameController.text = '';
    lastNameController.text = '';
    mobileNumberController.text = '';
    messageController.text = '';

    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  void checkValues() {
    print('Settings in the box');
    print('-------------------------------------------------');
    HopeBox hopeBox = box.get('hopebox');
    print('${hopeBox.images}, ${hopeBox.images.length}');
    print('${hopeBox.videos}, ${hopeBox.videos.length}');
    print('${hopeBox.recordings}, ${hopeBox.recordings.length}');
    print('${hopeBox.contactPerson}');

    print('Settings in the controller');
    print('-------------------------------------------------');
    print('$images, ${images.length}');
    print('$videos, ${videos.length}');
    print('$recordings, ${recordings.length}');
    print('$contactPerson');
  }

  void resetContactValue() {
    HopeBox hopeBox = box.get('hopebox');
    firstNameController.text = hopeBox.contactPerson.getFirstName();
    lastNameController.text = hopeBox.contactPerson.getLastName();
    mobileNumberController.text = hopeBox.contactPerson.getMobileNumber();
    messageController.text = hopeBox.contactPerson.getMessage();
  }
}
