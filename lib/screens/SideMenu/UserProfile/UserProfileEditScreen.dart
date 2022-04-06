import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:intl/intl.dart';

import 'package:flutter_application_1/controllers/userProfileController.dart';

class UserProfileEditScreen extends StatefulWidget {
  const UserProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileEditScreen> createState() => _UserProfileEditScreenState();
}

class _UserProfileEditScreenState extends State<UserProfileEditScreen> {
  final UserProfileController _profileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Object gender = _profileController.gender == 'Male'
        ? 'M'
        : _profileController.gender == 'Female'
            ? 'F'
            : 'P';
    var selectedDate =
        DateTime.tryParse(_profileController.birthdayController.text);

    List options = [
      {'name': 'Male', 'value': 'M'},
      {'name': 'Female', 'value': 'F'},
      {'name': 'Rather not say...', 'value': 'P'}
    ];

    updateProfile() {
      print('Profile updated');
      _profileController.updateValues();
    }

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
              DateFormat('yyyy-MM-d').format(picked);
        });
      }
    }

    // ensures that if the user pressed the back button after changing values without saving, the controllers values remain the same
    return WillPopScope(
      onWillPop: () {
        _profileController.resetAllValues();
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
                    Get.back();
                  }),
              backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
              title: Text('Edit Profile',
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.neutralBlack02))),
          primary: true,
          body: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: SingleChildScrollView(
                  child: Wrap(
                    children: [
                      _buildTextField(
                          fieldName: 'First Name',
                          hintText: 'Enter your first name',
                          controller: _profileController.firstNameController),
                      _buildTextField(
                          fieldName: 'Last Name',
                          hintText: 'Enter your last name',
                          controller: _profileController.lastNameController),
                      _buildTextField(
                          fieldName: 'Nickname',
                          hintText: 'Enter your nickname',
                          controller: _profileController.nicknameController),
                      Padding(
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SizedBox(
                          height: 50,
                          child: DropdownButtonFormField(
                            style: const TextStyle(fontSize: 14.0),
                            decoration:
                                textFormFieldDecoration('Enter your gender'),
                            value: gender,
                            icon: const Icon(Icons.arrow_drop_down),
                            items: options.map((map) {
                              return DropdownMenuItem(
                                  child: Text(map['name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .neutralBlack02)),
                                  value: map['value']);
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                gender = value!;
                              });
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
                      Divider(
                        color: Theme.of(context).colorScheme.neutralWhite03,
                        height: 25,
                        thickness: 2,
                      ),
                      InkWell(
                        splashColor:
                            Theme.of(context).colorScheme.neutralGray02,
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                fontWeight: FontWeight.w600)),
                                    WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                        child: Icon(
                                            Icons.keyboard_arrow_right_sharp,
                                            size: 30,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .neutralGray01))
                                  ]),
                                )
                              ]),
                        ),
                      ),
                    ],
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
                          onPressed: () {
                            _profileController.validate
                                ? updateProfile()
                                : null;
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
