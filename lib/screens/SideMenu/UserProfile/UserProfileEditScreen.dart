import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/settingsController.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_application_1/controllers/userProfileController.dart';

class UserProfileEditScreen extends StatefulWidget {
  const UserProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileEditScreen> createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  final UserProfileController _profileController =
      Get.put(UserProfileController());
  final SettingsController _settingsController = Get.put(SettingsController());

  final ImagePicker _picker = ImagePicker();
  var _storedImage = null;
  var _imagePath;

  @override
  void initState() {
    super.initState();
    _storedImage = _settingsController.imagePath.value != ''
        ? File(_settingsController.imagePath.value)
        : null;
    _imagePath = _settingsController.imagePath.value != ''
        ? _settingsController.imagePath.value
        : null;
  }

  @override
  Widget build(BuildContext context) {
    print(_profileController.gender);
    var selectedDate =
        DateTime.tryParse(_profileController.birthdayController.text);

    InputDecoration textFormFieldDecoration(String hintText) {
      return InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        fillColor: Theme.of(context).colorScheme.neutralWhite01,
        filled: true,
        hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.neutralGray03),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Theme.of(context).colorScheme.neutralWhite04,
        )),
      );
    }

    _buildTextField({fieldName, hintText, controller, onTap}) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(fieldName,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Theme.of(context).colorScheme.neutralGray04,
                    fontWeight: FontWeight.w600))),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            onTap: onTap,
            style: const TextStyle(
              fontSize: 14.0,
            ),
            controller: controller,
            decoration: textFormFieldDecoration(hintText),
          ),
        )
      ]);
    }

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              textTheme: TextTheme(
                subtitle1: TextStyle(
                    color: Theme.of(context).colorScheme.neutralBlack02),
                button: TextStyle(
                    color: Theme.of(context).colorScheme.intGreenMain),
              ),
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.intGreenMain,
                onSecondary: Theme.of(context).colorScheme.neutralBlack02,
                onPrimary: Theme.of(context).colorScheme.neutralWhite01,
                surface: Theme.of(context).colorScheme.neutralBlack02,
                onSurface: Theme.of(context).colorScheme.neutralBlack02,
                secondary: Theme.of(context).colorScheme.neutralBlack02,
              ),
              dialogBackgroundColor:
                  Theme.of(context).colorScheme.neutralWhite01,
            ),
            child: child ?? const Text(''),
          );
        },
        initialDate: selectedDate!,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
      );
      if (picked != null && picked != selectedDate) {
        setState(() {
          _profileController.birthdayController.text =
              DateFormat('yyyy-MM-dd').format(picked);
        });
      }
    }

    // ensures that if the user pressed the back button after changing values without saving, the controllers values remain the same
    return WillPopScope(
      onWillPop: () {
        _profileController.resetAllValues();
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
                    _profileController.resetAllValues();
                    _settingsController.resetAllValues();
                    Get.back();
                    Get.offAndToNamed('/userProfileScreen');
                  }),
              backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
              title: Text('Edit Profile',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.neutralBlack02))),
          primary: true,
          body: Stack(
            children: [
              SafeArea(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        InkWell(
                          onTap: () async {
                            final image = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (image == null) {
                              return;
                            }
                            setState(() {
                              _storedImage = File(image.path);
                              _imagePath = basename(image.path);
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                alignment: Alignment.center,
                                child: (_storedImage != null)
                                    ? CircleAvatar(
                                        radius: 100,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.file(
                                            _storedImage,
                                            width: 200.0,
                                            height: 200.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ))
                                    : SvgPicture.asset(
                                        'assets/images/orange_plus.svg',
                                        width: 200),
                              ),
                              Visibility(
                                visible:
                                    _settingsController.framePath.value != '',
                                child: SvgPicture.asset(
                                    _settingsController.framePath.value,
                                    width: 200,
                                    height: 200),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _profileController.anon == 'false',
                          child: _buildTextField(
                              fieldName: 'First Name',
                              hintText: 'Enter your first name',
                              controller:
                                  _profileController.firstNameController),
                        ),
                        Visibility(
                          visible: _profileController.anon == 'false',
                          child: _buildTextField(
                              fieldName: 'Last Name',
                              hintText: 'Enter your last name',
                              controller:
                                  _profileController.lastNameController),
                        ),
                        _buildTextField(
                            fieldName: 'Nickname',
                            hintText: 'Enter your nickname',
                            controller: _profileController.nicknameController),
                        Visibility(
                          visible: _profileController.anon == 'false',
                          child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text('Gender',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralGray04,
                                          fontWeight: FontWeight.w600))),
                        ),
                        Visibility(
                          visible: _profileController.anon == 'false',
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: SizedBox(
                              height: 50,
                              child: DropdownButtonFormField(
                                style: const TextStyle(fontSize: 14.0),
                                dropdownColor: Theme.of(context)
                                    .colorScheme
                                    .neutralWhite01,
                                decoration: textFormFieldDecoration(
                                    'Enter your gender'),
                                value: _profileController.gender != ''
                                    ? _profileController.gender
                                    : 'P',
                                icon: const Icon(Icons.arrow_drop_down),
                                items: [
                                  DropdownMenuItem<String>(
                                    child: Text('Male',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralBlack02)),
                                    value: 'M',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('Female',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralBlack02)),
                                    value: 'F',
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text('Rather not say...',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralBlack02)),
                                    value: 'P',
                                  ),
                                ],
                                onChanged: (String? value) {
                                  _profileController.gender = value!;
                                },
                                validator: (input) {
                                  if (input == null) {
                                    return 'This field is required.';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _profileController.anon == 'false',
                          child: Divider(
                            color: Theme.of(context).colorScheme.neutralWhite03,
                            height: 25,
                            thickness: 2,
                          ),
                        ),
                        Visibility(
                          visible: _profileController.anon == 'false',
                          child: InkWell(
                            splashColor:
                                Theme.of(context).colorScheme.neutralGray02,
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Birthday',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralBlack02)),
                                    RichText(
                                      text: TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                            text: _profileController
                                                .birthdayController.text,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                ?.copyWith(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .neutralGray01,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                        WidgetSpan(
                                            alignment:
                                                PlaceholderAlignment.middle,
                                            child: Icon(
                                                Icons
                                                    .keyboard_arrow_right_sharp,
                                                size: 30,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .neutralGray01))
                                      ]),
                                    )
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: GetBuilder<UserProfileController>(
                        builder: (value) => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: _profileController.validate
                                  ? Theme.of(context).colorScheme.accentBlue02
                                  : Theme.of(context)
                                      .colorScheme
                                      .neutralWhite04),
                          onPressed: () async {
                            if (_profileController.validate) {
                              if (_imagePath !=
                                      _settingsController.imagePath.value &&
                                  _settingsController.imagePath.value != '') {
                                File file =
                                    File(_settingsController.imagePath.value);
                                file.delete();
                              }
                              if (_storedImage != null &&
                                  _imagePath !=
                                      _settingsController.imagePath.value) {
                                final appDir =
                                    await getApplicationDocumentsDirectory();
                                final savedImage = await _storedImage
                                    .copy('${appDir.path}/$_imagePath');
                                _settingsController.updateImagePathSettings(
                                    newImage: savedImage.path);
                              }
                              _profileController.updateValues();
                              Get.snackbar('Edit User Profile',
                                  'Your profile has been updated.',
                                  snackPosition: SnackPosition.BOTTOM);
                            }
                          },
                          child: Text('Save',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01,
                                      fontWeight: FontWeight.w600)),
                        ),
                      ),
                    )),
              )
            ],
          )),
    );
  }
}
