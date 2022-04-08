import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HopeBoxContactSetupScreen extends StatefulWidget {
  const HopeBoxContactSetupScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxContactSetupScreen> createState() =>
      _HopeBoxContactSetupScreenState();
}

class _HopeBoxContactSetupScreenState extends State<HopeBoxContactSetupScreen> {
  final ImagePicker _picker = ImagePicker();
  final HopeBoxController _hopeController = Get.put(HopeBoxController());
  final TextEditingController _noteController = TextEditingController();

  var _storedImage = null;
  var _imagePath;
  @override
  Widget build(BuildContext context) {
    InputDecoration textFormFieldDecoration(String hintText) {
      return InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        fillColor: Theme.of(context).colorScheme.neutralWhite01,
        filled: true,
        hintStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
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
            keyboardType: fieldName == 'Mobile Number'
                ? TextInputType.number
                : TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
            onTap: onTap,
            style: Theme.of(context).textTheme.bodyText1,
            controller: controller,
            decoration: textFormFieldDecoration(hintText),
          ),
        )
      ]);
    }

    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            leading: BackButton(
                color: Theme.of(context).colorScheme.accentBlue02,
                onPressed: () {
                  _hopeController.resetContactValue();
                  Get.back();
                }),
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            title: Text('Emergency Contact Setup',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.neutralBlack02))),
        primary: true,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              color: Theme.of(context).colorScheme.neutralWhite01,
              child: SingleChildScrollView(
                  child: Container(
                color: Theme.of(context).colorScheme.neutralWhite01,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                            'Your emergency contact would be alerted during extreme situations.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
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
                            : SvgPicture.asset('assets/images/orange_plus.svg',
                                width: 200),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text('Add a photo',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralGray04,
                                    fontWeight: FontWeight.w600)),
                      ),
                      _buildTextField(
                        fieldName: 'First Name',
                        hintText: 'Enter their first name',
                        controller: _hopeController.firstNameController,
                      ),
                      _buildTextField(
                        fieldName: 'Last Name',
                        hintText: 'Enter their last name',
                        controller: _hopeController.lastNameController,
                      ),
                      _buildTextField(
                        fieldName: 'Mobile Number',
                        hintText: 'Enter their mobile number',
                        controller: _hopeController.mobileNumberController,
                      ),
                      const SizedBox(
                        height: 75,
                      )
                    ]),
              )),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)),
                        elevation: 0,
                        primary: (_hopeController.firstNameController.text
                                        .trim() !=
                                    '' &&
                                _hopeController.lastNameController.text
                                        .trim() !=
                                    '' &&
                                _hopeController.mobileNumberController.text
                                        .trim() !=
                                    '' &&
                                _storedImage != null)
                            ? Theme.of(context).colorScheme.sunflowerYellow01
                            : Theme.of(context).colorScheme.neutralWhite04),
                    onPressed: () async {
                      if (_hopeController.firstNameController.text.trim() !=
                              '' &&
                          _hopeController.lastNameController.text.trim() !=
                              '' &&
                          _hopeController.mobileNumberController.text.trim() !=
                              '' &&
                          _storedImage != null) {
                        final appDir = await getApplicationDocumentsDirectory();
                        final savedImage = await _storedImage
                            .copy('${appDir.path}/$_imagePath');
                        _hopeController.saveContactDetails(savedImage.path);

                        Get.offAndToNamed('/hopeBoxContact');
                      }
                    },
                    child: Text('Save',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Theme.of(context).colorScheme.neutralWhite01,
                            fontWeight: FontWeight.w600))),
              ),
            )
          ],
        ));
  }
}
