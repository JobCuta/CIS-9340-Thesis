// import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/hopeBoxHive.dart';
import 'package:flutter_application_1/apis/hopeBoxObject.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HopeBoxController extends GetxController {
  Box box = Hive.box<HopeBox>('hopeBox');
  RxList images = [].obs;
  RxList videos = [].obs;
  RxList recordings = [].obs;

  void prepareTheObjects() {
    if (box.isEmpty) {
      HopeBox hopeBox = HopeBox(images: [], videos: [], recordings: []);
      box.put('hopebox', hopeBox);
    }
    HopeBox hopeBox = box.get('hopebox');
    images.value = hopeBox.images;
    videos.value = hopeBox.videos;
    recordings.value = hopeBox.recordings;

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
    hopeBox.images.add(newImage);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  void updateImage(index, desc, path) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newImage = HopeBoxObject(
        datetime: DateTime.now(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
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
    hopeBox.videos.add(newVideo);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  void updateVideo(index, desc, path, thumbnailPath) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newVideo = HopeBoxObject(
        datetime: DateTime.now(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
        thumbnailPath: thumbnailPath);
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
    hopeBox.recordings.add(newRecording);
    box.put('hopebox', hopeBox);
    checkValues();
    update();
  }

  void updateRecording(index, desc, path) {
    HopeBox hopeBox = box.get('hopebox');
    HopeBoxObject newRecording = HopeBoxObject(
        datetime: DateTime.now(),
        description: desc != '' ? desc : 'Default Placeholder',
        path: path,
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

  void checkValues() {
    print('Settings in the box');
    print('-------------------------------------------------');
    HopeBox hopeBox = box.get('hopebox');
    print('${hopeBox.images}, ${hopeBox.images.length}');
    print('${hopeBox.videos}, ${hopeBox.videos.length}');
    print('${hopeBox.recordings}, ${hopeBox.recordings.length}');

    print('Settings in the controller');
    print('-------------------------------------------------');
    print('$images, ${images.length}');
    print('$videos, ${videos.length}');
    print('$recordings, ${recordings.length}');
  }
}
