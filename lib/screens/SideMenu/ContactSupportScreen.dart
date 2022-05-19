import 'package:flutter/material.dart';
import 'package:flutter_application_1/apis/apis.dart';
import 'package:flutter_application_1/screens/SideMenu/SideMenu.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';

import '../../controllers/userProfileController.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({Key? key}) : super(key: key);

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  var messageController = TextEditingController();
  var platformResponse = '';
  final UserProfileController _profileController =
      Get.put(UserProfileController());

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
      appBar: AppBar(
          elevation: 1,
          iconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.accentBlue02),
          backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
          title: Text('Contact Us',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.neutralBlack02))),
      primary: true,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: SingleChildScrollView(
              child: Wrap(
                runSpacing: 25,
                alignment: WrapAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/contact.svg'),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 25.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.neutralWhite04,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: Text(
                        'Got a suggestion or complaint? Give us a message! We appreciate and feedback.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralGray04)),
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text('Message',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralGray04,
                                        fontWeight: FontWeight.w600))),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 100.0),
                          child: TextFormField(
                            // autofocus: true,
                            maxLines: 5,
                            textCapitalization: TextCapitalization.sentences,
                            style: const TextStyle(
                              fontSize: 14.0,
                            ),
                            controller: messageController,
                            decoration: textFormFieldDecoration(
                                'Enter your message here'),
                          ),
                        ),
                      ]),
                ],
              ),
            )),
      ),
      resizeToAvoidBottomInset: false,
      bottomSheet: Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: messageController.text.isNotEmpty
                    ? Theme.of(context).colorScheme.accentBlue02
                    : Theme.of(context).colorScheme.neutralWhite04),
            onPressed: () {
              messageController.text.isNotEmpty ? sendMessage() : null;
            },
            child: Text('Send',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    fontWeight: FontWeight.w600)),
          )),
    );
  }

  Future<void> sendMessage() async {
    // bool result = await UserProvider().sendCustomerFeedback('${_profileController.email} - ${messageController.text}');
    Get.defaultDialog(
        title: 'Successfully Sent!',
        titleStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.neutralBlack02),
        titlePadding: const EdgeInsets.only(top: 20),
        contentPadding: const EdgeInsets.all(20),
        content: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Divider(
                height: 10,
                thickness: 1,
                color: Theme.of(context).colorScheme.neutralWhite03,
              ),
            ),
            SvgPicture.asset('assets/images/email_sending.svg'),
            Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Your feedback is now being sent to our team.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).colorScheme.neutralBlack02))),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.accentBlue02,
                ),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Okay!',
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.neutralWhite01),
                ),
              ),
            )
          ],
        ));
    // if (result) {

    // } else {}

    // final Email email = Email(
    //   body: messageController.text,
    //   subject: 'Feedback about Kasiyanna - ${_profileController.email}',
    //   recipients: ['contactkasiyanna@gmail.com'],
    // );
    // try {
    //   await FlutterEmailSender.send(email);
    //   platformResponse = 'Email Sent!';
    // } catch (error) {
    //   print(error);
    //   platformResponse = error.toString();
    // }
    // Get.snackbar(
    //   'Contact Developers Email',
    //   platformResponse,
    //   snackPosition: SnackPosition.BOTTOM,
    // );
  }
}
