import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:intl/intl.dart';

class HopeBoxVideosScreen extends StatefulWidget {
  const HopeBoxVideosScreen({Key? key}) : super(key: key);

  @override
  State<HopeBoxVideosScreen> createState() => _HopeBoxVideosScreenState();
}

class _HopeBoxVideosScreenState extends State<HopeBoxVideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Videos',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralBlack02,
                fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                  iconSize: 30,
                  onPressed: () {
                    addVideosDialog();
                  },
                  icon: Icon(Icons.add,
                      color: Theme.of(context).colorScheme.neutralBlack02)),
            )
          ],
          leading:
              BackButton(color: Theme.of(context).colorScheme.accentBlue02),
          elevation: 1,
          primary: true,
          backgroundColor: Theme.of(context).colorScheme.neutralWhite01,
        ),
        body: Container(
            alignment: Alignment.center,
            child: Wrap(
              direction: Axis.vertical,
              spacing: 10,
              children: [
                SvgPicture.asset('assets/images/missing_video.svg'),
                Text('Nothing here yet...',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                        color: Theme.of(context).colorScheme.neutralGray01,
                        fontWeight: FontWeight.w600))
              ],
            )));
  }

  addVideosDialog() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            insetPadding: const EdgeInsets.all(20.0),
            title: Text(
              'Add a video recording',
              style: Theme.of(context).textTheme.headline5?.copyWith(
                  color: Theme.of(context).colorScheme.neutralBlack02,
                  fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              child: Container(
                color: Theme.of(context).colorScheme.neutralWhite01,
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
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
                        child: FittedBox(
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .neutralWhite04,
                                      width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              child: SvgPicture.asset(
                                  'assets/images/select_video.svg')),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralBlack02),
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
                                        .neutralGray01),
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
                          onPressed: () {},
                        ),
                      ),
                    ]),
              ),
            )));
  }
}
