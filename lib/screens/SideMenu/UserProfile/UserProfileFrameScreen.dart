import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/controllers/settingsController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Frame {
  String image;
  String name;
  int requiredLevel;

  Frame({required this.image, required this.name, required this.requiredLevel});
}

class UserProfileFrameScreen extends StatefulWidget {
  const UserProfileFrameScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileFrameScreen> createState() => _UserProfileFrameScreenState();
}

class _UserProfileFrameScreenState extends State<UserProfileFrameScreen> {
  final SettingsController _settingsController = Get.put(SettingsController());
  final LevelController _levelController = Get.put(LevelController());
  late int currentLevel;
  var _storedImage = null;
  var _imagePath;
  var selectedFrame;

  @override
  void initState() {
    super.initState();
    _storedImage = _settingsController.imagePath.value != ''
        ? File(_settingsController.imagePath.value)
        : null;
    _imagePath = _settingsController.imagePath.value != ''
        ? _settingsController.imagePath.value
        : null;
    selectedFrame = _settingsController.framePath.value != ''
        ? _settingsController.framePath.value
        : '';
    currentLevel = _levelController.currentLevel.value;
  }

  @override
  Widget build(BuildContext context) {
    List<Frame> frames = [
      Frame(
          image: 'assets/frames/apayao_v1.svg',
          name: 'Apayao V1',
          requiredLevel: 1),
      Frame(
          image: 'assets/frames/apayao_v2.svg',
          name: 'Apayao V2',
          requiredLevel: 1),
      Frame(
          image: 'assets/frames/kalinga_v1.svg',
          name: 'Kalinga V1',
          requiredLevel: 2),
      Frame(
          image: 'assets/frames/kalinga_v2.svg',
          name: 'Kalinga V2',
          requiredLevel: 2),
      Frame(
          image: 'assets/frames/abra_v1.svg',
          name: 'Abra V1',
          requiredLevel: 3),
      Frame(
          image: 'assets/frames/abra_v2.svg',
          name: 'Abra V2',
          requiredLevel: 3),
      Frame(
          image: 'assets/frames/mtProvince_v1.svg',
          name: 'Mt. Province V1',
          requiredLevel: 4),
      Frame(
          image: 'assets/frames/mtProvince_v2.svg',
          name: 'Mt. Province V2',
          requiredLevel: 4),
      Frame(
          image: 'assets/frames/ifugao_v1.svg',
          name: 'Ifugao V1',
          requiredLevel: 5),
      Frame(
          image: 'assets/frames/ifugao_v2.svg',
          name: 'Ifugao V2',
          requiredLevel: 5),
      Frame(
          image: 'assets/frames/benguet_v1.svg',
          name: 'Benguet V1',
          requiredLevel: 6),
      Frame(
          image: 'assets/frames/benguet_v2.svg',
          name: 'Benguet V2',
          requiredLevel: 6)
    ];

    return WillPopScope(
      onWillPop: () {
        _settingsController.resetAllValues();
        Get.back();
        Get.offAndToNamed('/userProfileScreen');
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
        appBar: AppBar(
            elevation: 1,
            leading: BackButton(
                color: Theme.of(context).colorScheme.accentBlue02,
                onPressed: () {
                  _settingsController.resetAllValues();
                  Get.back();
                  Get.offAndToNamed('/userProfileScreen');
                }),
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            title: Text('Edit Frame',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralBlack02))),
        primary: true,
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 90),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    width: MediaQuery.of(context).size.width,
                    child: (_storedImage != null)
                        ? CircleAvatar(
                            radius: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.file(
                                _storedImage,
                                width: 200.0,
                                height: 200.0,
                                fit: BoxFit.cover,
                              ),
                            ))
                        : SvgPicture.asset(
                            'assets/images/default_user_image.svg',
                            width: 200),
                  ),
                  Visibility(
                    visible: selectedFrame != '',
                    child: SvgPicture.asset(selectedFrame,
                        width: 200, height: 200),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  primary: true,
                  child: Column(children: [
                    SizedBox(
                      height: 180,
                      child: Row(
                        children: [
                          _buildFrameContainer(frames[0]),
                          _buildFrameContainer(frames[1]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildFrameContainer(frames[2]),
                          _buildFrameContainer(frames[3]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildFrameContainer(frames[4]),
                          _buildFrameContainer(frames[5]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildFrameContainer(frames[6]),
                          _buildFrameContainer(frames[7]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildFrameContainer(frames[8]),
                          _buildFrameContainer(frames[9]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 180,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildFrameContainer(frames[10]),
                          _buildFrameContainer(frames[11]),
                        ],
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
        bottomSheet: // Save Button
            Container(
                color: Theme.of(context).colorScheme.neutralWhite01,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).colorScheme.accentBlue02,
                    ),
                    onPressed: () {
                      _settingsController.updateFrameSettings(
                          newFrame: selectedFrame);
                      Get.snackbar('Edit Frame', 'Your frame has been updated.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.white60,
                          colorText: Colors.black87);
                    },
                    child: Text('Save',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).colorScheme.neutralWhite01,
                            fontWeight: FontWeight.w600)),
                  ),
                )),
      ),
    );
  }

  _buildFrameContainer(Frame frame) {
    return Expanded(
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: selectedFrame == frame.image
                  ? Theme.of(context).colorScheme.accentBlue02
                  : Colors.transparent,
              width: selectedFrame == frame.image ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              InkWell(
                onTap: () {
                  if (selectedFrame != frame.image) {
                    setState(() {
                      selectedFrame = frame.image;
                    });
                  } else {
                    setState(() {
                      selectedFrame = '';
                    });
                  }
                },
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.accentBlue01,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(frame.image),
                      height: constraints.maxHeight * 0.75,
                      width: constraints.maxWidth),
                  Container(
                      alignment: Alignment.center,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.20,
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.neutralWhite01,
                        border: Border.all(
                            color:
                                Theme.of(context).colorScheme.neutralWhite04),
                        borderRadius: const BorderRadius.vertical(
                            bottom: Radius.circular(10)),
                      ),
                      child: Text(
                        frame.name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).colorScheme.neutralBlack02),
                      ))
                ]),
              ),
              Visibility(
                visible: currentLevel < frame.requiredLevel,
                child: Container(
                    padding: const EdgeInsets.all(10),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.neutralWhite04),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Theme.of(context)
                          .colorScheme
                          .neutralBlack02
                          .withOpacity(0.5),
                    ),
                    child: const Icon(
                      Icons.lock_outline,
                      color: Colors.white,
                      size: 50,
                    )),
              ),
            ],
          ),
        );
      }),
    );
  }
}
