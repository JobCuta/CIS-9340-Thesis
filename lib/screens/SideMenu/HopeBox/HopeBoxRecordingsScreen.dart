import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class HopeBoxRecordingsScreen extends StatefulWidget {
  const HopeBoxRecordingsScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxRecordingsScreen> createState() =>
      _HopeBoxRecordingsScreenState();
}

class _HopeBoxRecordingsScreenState extends State<HopeBoxRecordingsScreen> {
  final HopeBoxController _hopeController = HopeBoxController();
  final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _hopeController.prepareTheObjects();
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text(
              'Recordings',
              style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: Theme.of(context).colorScheme.neutralBlack02,
                  fontWeight: FontWeight.w400),
            ),
            leading:
                BackButton(color: Theme.of(context).colorScheme.accentBlue02),
            elevation: 1,
            primary: true,
            backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    iconSize: 30,
                    onPressed: () {
                      AddEntry(context);
                    },
                    icon: Icon(Icons.add,
                        color: Theme.of(context).colorScheme.neutralBlack02)),
              )
            ]),
        body: Container(
            color: Theme.of(context).colorScheme.neutralWhite01,
            padding: const EdgeInsets.only(top: 10),
            alignment: _hopeController.recordings.isEmpty
                ? Alignment.center
                : Alignment.topCenter,
            child: _hopeController.recordings.isNotEmpty
                ? Obx(() {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _hopeController.recordings.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 25),
                              child: Card(
                                  elevation: 5,
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 15),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 30,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        '${DateFormat.EEEE().format(_hopeController.recordings[index].getDateTime()).toString().toUpperCase()}, ${DateFormat.MMMMd().format(_hopeController.recordings[index].getDateTime()).toString().toUpperCase()}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .caption
                                                            ?.copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .neutralGray02)),
                                                    PopupMenuButton(
                                                        icon: const Icon(
                                                            Icons.more_horiz),
                                                        onSelected: (value) {
                                                          if (value == 'Edit') {
                                                            editEntry(
                                                                context, index);
                                                          } else if (value ==
                                                              'Delete') {
                                                            DeleteEntry(
                                                                context, index);
                                                          }
                                                        },
                                                        itemBuilder:
                                                            (BuildContext
                                                                context) {
                                                          return <
                                                              PopupMenuEntry<
                                                                  String>>[
                                                            PopupMenuItem(
                                                              value: 'Edit',
                                                              child: Text(
                                                                  'Edit',
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyText2),
                                                            ),
                                                            PopupMenuItem(
                                                              value: 'Delete',
                                                              child: Text(
                                                                'Delete',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText2
                                                                    ?.copyWith(
                                                                        color: Theme.of(context)
                                                                            .colorScheme
                                                                            .accentRed02),
                                                              ),
                                                            ),
                                                          ];
                                                        })
                                                  ]),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/images/select_recording_display.svg',
                                                  height: 50,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, left: 15),
                                                  child: Text(
                                                      _hopeController
                                                          .recordings[index]
                                                          .getDescription(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .neutralGray04)),
                                                )
                                              ],
                                            ),
                                          ]))));
                        });
                  })
                : Wrap(
                    direction: Axis.vertical,
                    spacing: 10,
                    children: [
                      SvgPicture.asset('assets/images/missing_image.svg'),
                      Text('Nothing here yet...',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralGray01,
                                  fontWeight: FontWeight.w600))
                    ],
                  )));
  }

  DeleteEntry(BuildContext context, int index) {
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
                    Text('Are you sure you want to delete this recording?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.neutralBlack02)),
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
                              final file = File(
                                  _hopeController.recordings[index].getPath());
                              await file.delete();
                              _hopeController.removeRecording(index);
                              Get.back();
                              Get.offAndToNamed('/hopeBoxRecordings');
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

  AddEntry(context) {
    _noteController.text = '';
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _storedFile = null;
          var _filePath;
          return AlertDialog(
              insetPadding: const EdgeInsets.all(20.0),
              title: Text(
                'Add a recording',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Theme.of(context).colorScheme.neutralBlack02,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              content:
                  StatefulBuilder(builder: (context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Container(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Put your favorite recordings and why they mean so much to you!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralGray04,
                                      fontWeight: FontWeight.w400)),
                          InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.audio,
                                allowMultiple: false,
                                onFileLoading: (FilePickerStatus status) =>
                                    print(status),
                              );
                              if (result == null) {
                                return;
                              }
                              File file = File(result.files.single.path!);

                              setState(() {
                                _storedFile = File(result.files.single.path!);
                                _filePath = basename(result.files.single.path!);
                              });
                            },
                            child: FittedBox(
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralWhite04,
                                          width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4))),
                                  child: (_storedFile != null)
                                      ? SvgPicture.asset(
                                          'assets/images/select_recording_uploaded.svg')
                                      : SvgPicture.asset(
                                          'assets/images/select_recording.svg')),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                  DateFormat.yMMMMd().format(
                                    DateTime.now(),
                                  ),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralGray04,
                                          fontWeight: FontWeight.w400)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: TextFormField(
                              controller: _noteController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02,
                                  ),
                              // initialValue: note,
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.description),
                                hintText: 'Add a note',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite04),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 13.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                child: Text(
                                  'Add',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralWhite01,
                                          fontWeight: FontWeight.w600),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    elevation: 0,
                                    primary: Theme.of(context)
                                        .colorScheme
                                        .sunflowerYellow01),
                                onPressed: () async {
                                  if (_storedFile != null) {
                                    final appDir =
                                        await getApplicationDocumentsDirectory();

                                    final savedFile = await _storedFile
                                        .copy('${appDir.path}/$_filePath');
                                    print(savedFile.path);
                                    _hopeController.addRecording(
                                        _noteController.text, savedFile.path);
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxRecordings');
                                  }
                                }),
                          ),
                        ]),
                  ),
                );
              }));
        });
  }

  void editEntry(context, int index) {
    _noteController.text = _hopeController.recordings[index].getDescription();
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _storedFile = File(_hopeController.recordings[index].getPath());
          var _filePath = _hopeController.recordings[index].getPath();
          return AlertDialog(
              insetPadding: const EdgeInsets.all(20.0),
              title: Text(
                'Edit recording entry',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Theme.of(context).colorScheme.neutralBlack02,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              content:
                  StatefulBuilder(builder: (context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Container(
                    color: Theme.of(context).colorScheme.neutralWhite01,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Put your favorite recordings and why they mean so much to you!',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralGray04,
                                      fontWeight: FontWeight.w400)),
                          InkWell(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.audio,
                                allowMultiple: false,
                                onFileLoading: (FilePickerStatus status) =>
                                    print(status),
                              );
                              if (result == null) {
                                return;
                              }
                              File file = File(result.files.single.path!);

                              setState(() {
                                _storedFile = File(result.files.single.path!);
                                _filePath = basename(result.files.single.path!);
                              });
                            },
                            child: FittedBox(
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.all(10),
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralWhite04,
                                          width: 1),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4))),
                                  child: (_storedFile != null)
                                      ? SvgPicture.asset(
                                          'assets/images/select_recording_uploaded.svg')
                                      : SvgPicture.asset(
                                          'assets/images/select_recording.svg')),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                  DateFormat.yMMMMd().format(
                                    DateTime.now(),
                                  ),
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralGray04,
                                          fontWeight: FontWeight.w400)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 20),
                            child: TextFormField(
                              controller: _noteController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralBlack02,
                                  ),
                              // initialValue: note,
                              maxLines: 1,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.description),
                                hintText: 'Add a note',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite04),
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 13.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                                child: Text(
                                  'Save',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .neutralWhite01,
                                          fontWeight: FontWeight.w600),
                                ),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    elevation: 0,
                                    primary: Theme.of(context)
                                        .colorScheme
                                        .sunflowerYellow01),
                                onPressed: () async {
                                  if (_filePath ==
                                      _hopeController.recordings[index]
                                          .getPath()) {
                                    _hopeController.updateRecordingDesc(
                                        index, _noteController.text);
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxRecordings');
                                  } else if (_storedFile != null) {
                                    final appDir =
                                        await getApplicationDocumentsDirectory();

                                    final savedImage = await _storedFile
                                        .copy('${appDir.path}/$_filePath');
                                    print(savedImage.path);
                                    _hopeController.updateRecording(index,
                                        _noteController.text, savedImage.path);
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxRecordings');
                                  }
                                }),
                          ),
                        ]),
                  ),
                );
              }));
        });
  }
}
