import 'dart:io';

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
  late VideoPlayerController _controller;
  final String filePath = Get.arguments["filePath"]!;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(filePath))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
          color: Theme.of(context).colorScheme.neutralWhite01,
          child: SingleChildScrollView(
              child: _controller.value.isInitialized
                  ? Wrap(
                      runSpacing: 20,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 300),
                          child: Container(
                            alignment: Alignment.center,
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        ),
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: VideoProgressColors(
                              backgroundColor:
                                  Theme.of(context).colorScheme.neutralWhite01,
                              bufferedColor:
                                  Theme.of(context).colorScheme.accentBlue01,
                              playedColor:
                                  Theme.of(context).colorScheme.accentBlue02),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .accentBlue02,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    icon: Icon(Icons.fast_rewind,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite01),
                                    onPressed: () {
                                      _controller.seekTo(Duration(
                                          seconds: _controller
                                                  .value.position.inSeconds -
                                              5));
                                    })),
                            Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .accentBlue02,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    icon: Icon(
                                        _controller.value.isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite01),
                                    onPressed: () {
                                      setState(() {
                                        if (_controller.value.isPlaying) {
                                          _controller.pause();
                                        } else {
                                          _controller.play();
                                        }
                                      });
                                    })),
                            Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .accentBlue02,
                                    borderRadius: BorderRadius.circular(100)),
                                child: IconButton(
                                    icon: Icon(Icons.fast_forward,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite01),
                                    onPressed: () {
                                      _controller.seekTo(Duration(
                                          seconds: _controller
                                                  .value.position.inSeconds +
                                              5));
                                    }))
                          ],
                        )
                      ],
                    )
                  : Container()),
        ));
  }
}
