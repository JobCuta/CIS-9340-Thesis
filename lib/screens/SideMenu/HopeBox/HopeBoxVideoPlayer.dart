import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/hopeBoxController.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:video_player/video_player.dart';

import 'package:intl/intl.dart';

class HopeBoxVideoPlayer extends StatefulWidget {
  HopeBoxVideoPlayer({Key? key}) : super(key: key);

  @override
  State<HopeBoxVideoPlayer> createState() => _HopeBoxVideoPlayerState();
}

class _HopeBoxVideoPlayerState extends State<HopeBoxVideoPlayer> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  final String filePath = Get.arguments["filePath"]!;
  final String thumbnailPath = Get.arguments["thumbnailPath"]!;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.file(File(filePath));
    await Future.wait([_videoPlayerController1.initialize()]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Theme.of(context).colorScheme.accentBlue02,
        handleColor: Theme.of(context).colorScheme.accentBlue02,
        backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
        bufferedColor: Theme.of(context).colorScheme.accentBlue02,
      ),
    );
  }

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();
    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).colorScheme.neutralWhite01,
          child: Center(
              child: _chewieController != null &&
                      _chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                              color:
                                  Theme.of(context).colorScheme.neutralWhite01),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Loading...',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite01))
                        ],
                      ),
                    )),
        ));
  }
}
