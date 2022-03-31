import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'package:intl/intl.dart';

class HopeBoxVideosScreen extends StatefulWidget {
  const HopeBoxVideosScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxVideosScreen> createState() => _HopeBoxVideosScreenState();
}

class _HopeBoxVideosScreenState extends State<HopeBoxVideosScreen> {
  final ImagePicker _picker = ImagePicker();
  final HopeBoxController _hopeController = HopeBoxController();
  final TextEditingController _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _hopeController.prepareTheObjects();
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: Text(
              'Videos',
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
            alignment: _hopeController.videos.isEmpty
                ? Alignment.center
                : Alignment.topCenter,
            child: _hopeController.videos.isNotEmpty
                ? Obx(() {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: _hopeController.videos.length,
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
                                                    '${DateFormat.EEEE().format(_hopeController.videos[index].getDateTime()).toString().toUpperCase()}, ${DateFormat.MMMMd().format(_hopeController.videos[index].getDateTime()).toString().toUpperCase()}',
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
                                                        DeleteEntry(
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
                                              _hopeController.videos[index]
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
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed('/hopeBoxVideoPlayer',
                                                arguments: {
                                                  "filePath": _hopeController
                                                      .videos[index]
                                                      .getPath()
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Image.file(File(
                                                _hopeController.videos[index]
                                                    .getThumbnailPath())),
                                          ),
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
                      SvgPicture.asset('assets/images/missing_video.svg'),
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
                    Text('Are you sure you want to delete this video?',
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
                                  File(_hopeController.videos[index].getPath());
                              await file.delete();
                              _hopeController.removeVideo(index);
                              Get.back();
                              Get.offAndToNamed('/hopeBoxVideos');
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
    var thumbnail;
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _storedVideo = null;
          var _videoPath;

          return AlertDialog(
              insetPadding: const EdgeInsets.all(20.0),
              title: Text(
                'Add a video recording',
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
                              'Put your favorite videos and why they mean so much to you!',
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
                              final video = await _picker.pickVideo(
                                  source: ImageSource.gallery);
                              if (video == null) {
                                return;
                              }
                              setState(() {
                                _storedVideo = File(video.path);
                                _videoPath = basename(video.path);
                              });
                              final _thumbnail =
                                  await VideoThumbnail.thumbnailFile(
                                video: _storedVideo.path,
                                thumbnailPath:
                                    (await getApplicationDocumentsDirectory())
                                        .path,
                                imageFormat: ImageFormat.PNG,
                                // maxWidth:
                                // 200, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                                quality: 100,
                              );

                              setState(() {
                                thumbnail = _thumbnail;
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
                                  child: (_storedVideo != null &&
                                          thumbnail != null)
                                      ? Container(
                                          height: 200,
                                          margin: const EdgeInsets.all(10),
                                          child: Image.file(
                                            File(thumbnail.toString()),
                                            fit: BoxFit.fitHeight,
                                          ))
                                      : SvgPicture.asset(
                                          'assets/images/select_video.svg')),
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
                                  if (_storedVideo != null) {
                                    final appDir =
                                        await getApplicationDocumentsDirectory();
                                    final savedVideo = await _storedVideo
                                        .copy('${appDir.path}/$_videoPath');
                                    print(savedVideo.path);
                                    _hopeController.addVideo(
                                        _noteController.text,
                                        savedVideo.path,
                                        thumbnail.toString());
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxVideos');
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
    _noteController.text = _hopeController.videos[index].getDescription();
    var thumbnail = _hopeController.videos[index].getThumbnailPath();
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          var _storedVideo = File(_hopeController.videos[index].getPath());
          var _videoPath = _hopeController.videos[index].getPath();

          return AlertDialog(
              insetPadding: const EdgeInsets.all(20.0),
              title: Text(
                'Edit video entry',
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
                              'Put your favorite videos and why they mean so much to you!',
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
                              final video = await _picker.pickVideo(
                                  source: ImageSource.gallery);
                              if (video == null) {
                                return;
                              }
                              setState(() {
                                _storedVideo = File(video.path);
                                _videoPath = basename(video.path);
                              });
                              final _thumbnail =
                                  await VideoThumbnail.thumbnailFile(
                                video: _storedVideo.path,
                                thumbnailPath:
                                    (await getApplicationDocumentsDirectory())
                                        .path,
                                imageFormat: ImageFormat.PNG,
                                // maxWidth:
                                // 200, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
                                quality: 100,
                              );

                              setState(() {
                                thumbnail = _thumbnail;
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
                                  child: (_storedVideo != null &&
                                          thumbnail != null)
                                      ? Container(
                                          height: 200,
                                          margin: const EdgeInsets.all(10),
                                          child: Image.file(
                                            File(thumbnail.toString()),
                                            fit: BoxFit.fitHeight,
                                          ))
                                      : SvgPicture.asset(
                                          'assets/images/select_video.svg')),
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
                                  if (_videoPath ==
                                      _hopeController.videos[index].getPath()) {
                                    _hopeController.updateVideoDesc(
                                        index, _noteController.text);
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxVideos');
                                  } else if (_storedVideo != null) {
                                    final appDir =
                                        await getApplicationDocumentsDirectory();

                                    final savedVideo = await _storedVideo
                                        .copy('${appDir.path}/$_videoPath');
                                    print(savedVideo.path);
                                    _hopeController.updateVideo(
                                        index,
                                        _noteController.text,
                                        savedVideo.path,
                                        thumbnail.toString());
                                    Get.back();
                                    Get.offAndToNamed('/hopeBoxVideos');
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
