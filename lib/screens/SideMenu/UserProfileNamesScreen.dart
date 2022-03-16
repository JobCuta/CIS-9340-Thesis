import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_application_1/controllers/userProfileController.dart';

class UserProfileNamesScreen extends StatefulWidget {
  const UserProfileNamesScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileNamesScreen> createState() => _UserProfileNamesScreenState();
}

class _UserProfileNamesScreenState extends State<UserProfileNamesScreen> {
  final UserProfileController _profileController =
      Get.put(UserProfileController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildTextField(fieldName, controller) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(fieldName,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: const Color(0xff5E6668),
                    fontWeight: FontWeight.w600))),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            style: const TextStyle(
              fontSize: 14.0,
            ),
            controller: controller,
            decoration: InputDecoration(
              errorText:
                  controller.text == '' ? 'This field is required' : null,
              border: const OutlineInputBorder(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.grey.shade300,
              )),
            ),
            // onTap: () {},
          ),
        )
      ]);
    }

    return Scaffold(
        appBar: AppBar(
            elevation: 1,
            leading: const BackButton(color: Color(0xff4CA7FC)),
            backgroundColor: Colors.white,
            title: Text('First & Last Name',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(fontWeight: FontWeight.w400))),
        primary: true,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: SingleChildScrollView(
                child: Wrap(
                  children: [
                    _buildTextField(
                        'First Name', _profileController.firstNameController),
                    _buildTextField(
                        'Last Name', _profileController.lastNameController),
                    const Divider(
                      color: Color(0xffF0F1F1),
                      height: 25,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: _buildTextField(
                          'Nickname', _profileController.nicknameController),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: GetBuilder<UserProfileController>(
                      builder: (value) => ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: _profileController.validate
                                ? const Color(0xff4CA7FC)
                                : const Color(0xffE2E4E4)),
                        onPressed: () {
                          _profileController.validate ? updateProfile() : null;
                        },
                        child: Text('Save',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                      ),
                    ),
                  )),
            ),
          ],
        ));
  }

  updateProfile() {
    print('Profile updated');
  }
}
