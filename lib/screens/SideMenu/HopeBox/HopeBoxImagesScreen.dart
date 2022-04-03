import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:intl/intl.dart';

class HopeBoxImagesScreen extends StatefulWidget {
  const HopeBoxImagesScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxImagesScreen> createState() => _HopeBoxImagesScreenState();
}

class _HopeBoxImagesScreenState extends State<HopeBoxImagesScreen> {
  final ImagePicker _picker = ImagePicker();
  final HopeBoxController _hopeController = Get.put(HopeBoxController());
  final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text(
              'Images',
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
                      addEntry(context);
                    },
                    icon: Icon(Icons.add,
                        color: Theme.of(context).colorScheme.neutralBlack02)),
              )
            ]),
        body: Container(
            color: Theme.of(context).colorScheme.neutralWhite01,
            padding: const EdgeInsets.only(top: 10),
            alignment: _hopeController.images.isEmpty
                ? Alignment.center
                : Alignment.topCenter,
            child: _hopeController.images.isNotEmpty
                ? Obx(() {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _hopeController.images.length,
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
                                          height: 20,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${DateFormat.EEEE().format(_hopeController.images[index].getDateTime()).toString().toUpperCase()}, ${DateFormat.MMMMd().format(_hopeController.images[index].getDateTime()).toString().toUpperCase()}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .neutralGray02)),
                                                PopupMenuButton(
                                                    icon: Icon(Icons.more_horiz,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .neutralGray02),
                                                    onSelected: (value) {
                                                      if (value == 'Edit') {
                                                        editEntry(
                                                            context, index);
                                                      } else if (value ==
                                                          'Delete') {
                                                        deleteEntry(
                                                            context, index);
                                                      }
                                                    },
                                                    itemBuilder:
                                                        (BuildContext context) {
                                                      return <
                                                          PopupMenuEntry<
                                                              String>>[
                                                        PopupMenuItem(
                                                          value: 'Edit',
                                                          child: Text('Edit',
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
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .accentRed02),
                                                          ),
                                                        ),
                                                      ];
                                                    })
                                              ]),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                              _hopeController.images[index]
                                                  .getDescription(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .neutralGray04)),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Image.file(File(_hopeController
                                              .images[index]
                                              .getPath())),
                                        )
                                      ])),
                            ),
                          );
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

  addEntry(context) {
    _noteController.text = '';
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _storedImage = null;
          var _imagePath;
          return AlertDialog(
              insetPadding: const EdgeInsets.all(20.0),
              title: Text(
                'Add a Photo',
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
                          Text('Add photos that have inspired you for today!',
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
                                  child: (_storedImage != null)
                                      ? Container(
                                          height: 200,
                                          margin: const EdgeInsets.all(10),
                                          child: Image.file(
                                            _storedImage,
                                            fit: BoxFit.fitHeight,
                                          ))
                                      : SvgPicture.asset(
                                          'assets/images/select_photo.svg')),
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
                                  if (_storedImage != null) {
                                    final appDir =
                                        await getApplicationDocumentsDirectory();

                                    final savedImage = await _storedImage
                                        .copy('${appDir.path}/$_imagePath');
                                    _hopeController.addImage(
                                        _noteController.text, savedImage.path);
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxImages');
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
    _noteController.text =
        _hopeController.images[index].getDescription() != 'Default Placeholder'
            ? _hopeController.images[index].getDescription()
            : '';
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _storedImage = File(_hopeController.images[index].getPath());
          var _imagePath = _hopeController.images[index].getPath();
          return AlertDialog(
              insetPadding: const EdgeInsets.all(20.0),
              title: Text(
                'Edit photo entry',
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
                          Text('Add photos that have inspired you for today!',
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
                                  child: (_storedImage != null)
                                      ? Container(
                                          height: 200,
                                          margin: const EdgeInsets.all(10),
                                          child: Image.file(
                                            _storedImage,
                                            fit: BoxFit.fitHeight,
                                          ))
                                      : SvgPicture.asset(
                                          'assets/images/select_photo.svg')),
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
                                  if (_imagePath ==
                                      _hopeController.images[index].getPath()) {
                                    _hopeController.updateImageDesc(
                                        index, _noteController.text);
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxImages');
                                  } else if (_storedImage != null) {
                                    File file = File(_hopeController
                                        .images[index]
                                        .getPath());
                                    file.delete();
                                    final appDir =
                                        await getApplicationDocumentsDirectory();

                                    final savedImage = await _storedImage
                                        .copy('${appDir.path}/$_imagePath');
                                    _hopeController.updateImage(index,
                                        _noteController.text, savedImage.path);
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxImages');
                                  }
                                }),
                          ),
                        ]),
                  ),
                );
              }));
        });
  }

  deleteEntry(BuildContext context, int index) {
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
                    Text('Are you sure you want to delete this image?',
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
                              final file =
                                  File(_hopeController.images[index].getPath());
                              await file.delete();
                              _hopeController.removeImage(index);
                              Get.back();
                              Get.offAndToNamed('/hopeBoxImages');
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
}
