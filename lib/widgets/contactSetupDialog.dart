import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

final HopeBoxController _hopeController = HopeBoxController();

showContactSetUp(context) {
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

  final ImagePicker _picker = ImagePicker();
  final HopeBoxController _hopeController = HopeBoxController();
  final TextEditingController _noteController = TextEditingController();
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        var _storedImage = null;
        var _imagePath;
        return AlertDialog(
          insetPadding: const EdgeInsets.all(20.0),
          title: Text(
            'Emergency Contact Setup',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          content: StatefulBuilder(builder: (context, StateSetter setState) {
            return SingleChildScrollView(
                child: Container(
              color: Theme.of(context).colorScheme.neutralWhite01,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                          'Your emergency contact would be alerted during extreme situations.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralGray04,
                                  fontWeight: FontWeight.w400)),
                    ),
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
                      child: (_storedImage != null)
                          ? CircleAvatar(
                              radius: 50,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.file(
                                  _storedImage,
                                  width: 200.0,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                ),
                              ))
                          : SvgPicture.asset('assets/images/orange_plus.svg',
                              width: 100),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text('Add a photo',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color:
                                  Theme.of(context).colorScheme.neutralGray04,
                              fontWeight: FontWeight.w600)),
                    ),
                    _buildTextField(
                      fieldName: 'First Name',
                      hintText: 'Enter your first name',
                      controller: _hopeController.firstNameController,
                    ),
                    _buildTextField(
                      fieldName: 'Last Name',
                      hintText: 'Enter your last name',
                      controller: _hopeController.lastNameController,
                    ),
                    _buildTextField(
                      fieldName: 'Mobile Number',
                      hintText: 'Enter your mobile number',
                      controller: _hopeController.mobileNumberController,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3)),
                              elevation: 0,
                              primary: (_hopeController.firstNameController.text
                                              .trim() !=
                                          '' ||
                                      _hopeController.lastNameController.text
                                              .trim() !=
                                          '' ||
                                      _hopeController.mobileNumberController.text
                                              .trim() !=
                                          '')
                                  ? Theme.of(context)
                                      .colorScheme
                                      .sunflowerYellow01
                                  : Theme.of(context)
                                      .colorScheme
                                      .neutralWhite04),
                          onPressed: () async {
                            if (_hopeController.firstNameController.text
                                        .trim() !=
                                    '' ||
                                _hopeController.lastNameController.text
                                        .trim() !=
                                    '' ||
                                _hopeController.mobileNumberController.text
                                        .trim() !=
                                    '') {
                              if (_storedImage != null) {
                                final appDir =
                                    await getApplicationDocumentsDirectory();
                                final savedImage = await _storedImage
                                    .copy('${appDir.path}/$_imagePath');
                                print(savedImage.path);
                                _hopeController
                                    .saveContactDetails(savedImage.path);

                                Get.back();
                                Get.offAndToNamed('/hopeBoxContact');
                              }
                            }
                          },
                          child: Text('Add',
                              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                  color: Theme.of(context).colorScheme.neutralWhite01,
                                  fontWeight: FontWeight.w600))),
                    )
                  ]),
            ));
          }),
        );
      });
}
