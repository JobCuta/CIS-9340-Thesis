import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:flutter_application_1/widgets/contactSetupDialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class HopeBoxContactScreen extends StatefulWidget {
  const HopeBoxContactScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxContactScreen> createState() => _HopeBoxContactScreenState();
}

class _HopeBoxContactScreenState extends State<HopeBoxContactScreen> {
  final HopeBoxController _hopeController = Get.put(HopeBoxController());

  @override
  Widget build(BuildContext context) {
    _hopeController.prepareTheObjects();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            collapsedHeight: 60,
            expandedHeight: 50,
            title: Text('Contact Support Person',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    fontWeight: FontWeight.w400)),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(200),
              child: Wrap(
                  direction: Axis.vertical,
                  spacing: 15,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                          radius: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.file(
                              File(_hopeController.contactPerson.value
                                  .getPathImage()),
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                          '${_hopeController.contactPerson.value.getFirstName()} ${_hopeController.contactPerson.value.getLastName()}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01,
                                  fontWeight: FontWeight.w600)),
                    ),
                  ]),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                  decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/background_images/blue_background.png',
                  ),
                  fit: BoxFit.cover,
                ),
              )),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  // crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                          _hopeController.contactPerson.value.getMobileNumber(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralBlack02,
                                  fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: InkWell(
                              splashColor:
                                  Theme.of(context).colorScheme.neutralGray02,
                              onTap: () {
                                launch(
                                    'tel:${_hopeController.contactPerson.value.getMobileNumber()}');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: SvgPicture.asset(
                                        'assets/images/call_icon.svg',
                                        width: 30.0),
                                  ),
                                  Text('Call',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .intGreenMain,
                                              fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                          ),
                          // VerticalDivider(
                          //     thickness: 2,
                          //     color:
                          //         Theme.of(context).colorScheme.neutralGray02),
                          Expanded(
                            child: InkWell(
                              splashColor:
                                  Theme.of(context).colorScheme.neutralGray02,
                              onTap: () {
                                final message =
                                    'Hey ${_hopeController.contactPerson.value.getFirstName()}, I really need your help right now. I feel like I am at risk o harming myself or others. Please contact me as soon as you can.';
                                launch(
                                    'sms:${_hopeController.contactPerson.value.getMobileNumber()}?body=$message');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: SvgPicture.asset(
                                        'assets/images/message_icon.svg',
                                        width: 30.0),
                                  ),
                                  Text('Message',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .accentBlue02,
                                              fontWeight: FontWeight.w600))
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.neutralWhite03,
                      height: 30,
                      thickness: 1,
                    ),
                    InkWell(
                      splashColor: Theme.of(context).colorScheme.neutralGray02,
                      onTap: () {
                        Get.toNamed('/hopeBoxContactEdit');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Update Emergency Contact',
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
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                          Icons.keyboard_arrow_right_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralGray01))
                                ]),
                              )
                            ]),
                      ),
                    ),
                    InkWell(
                      splashColor: Theme.of(context).colorScheme.neutralGray02,
                      onTap: () {
                        showDeleteContactConfirmationDialog(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Delete Emergency Contact',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .accentRed02)),
                              RichText(
                                text: TextSpan(children: <InlineSpan>[
                                  WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Icon(
                                          Icons.keyboard_arrow_right_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralGray01))
                                ]),
                              )
                            ]),
                      ),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}

showDeleteContactConfirmationDialog(context) {
  final HopeBoxController _hopeController = Get.put(HopeBoxController());
  _hopeController.prepareTheObjects();

  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
          insetPadding: const EdgeInsets.all(50.0),
          title: Text(
            'Are you sure?',
            style: Theme.of(context).textTheme.headline5?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            child: Wrap(
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/trash.svg'),
                  Text(
                      'Are you sure you want to delete your emergency contact?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.neutralBlack02)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          child: Text(
                            'Delete',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .accentRed02,
                                    fontWeight: FontWeight.w600),
                          ),
                          onPressed: () async {
                            final file = File(_hopeController
                                .contactPerson.value
                                .getPathImage());
                            await file.delete();
                            _hopeController.deleteContactDetails();
                            Get.back();
                            Get.offAndToNamed('/hopeBox');
                          },
                        ),
                        TextButton(
                            child: Text(
                              'Nevermind',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralBlack02,
                                      fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              Get.back();
                            }),
                      ])
                ]),
          )));
}
