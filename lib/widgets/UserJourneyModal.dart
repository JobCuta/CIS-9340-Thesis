import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/main/UserJourney.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(const UserJourneyModal());

class UserJourneyModalWidget extends StatefulWidget {
  const UserJourneyModalWidget({Key? key}) : super(key: key);

  @override
  State<UserJourneyModalWidget> createState() => _UserJourneyModalState();
}

class _UserJourneyModalState extends State<UserJourneyModalWidget> {
  String first = "We are here in Apayao! Welcome to level 1! in this level,";
  String second =
      "I am here to share to you about mental health. It shows that you are experiencing extreme and unexpected changes in mood. ";
  String third =
      "Here are the activities that are available  in this level. You need to finish all of the activities so that you can go to the next region. ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Your Adventure',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Theme.of(context).colorScheme.neutralWhite01,
              fontWeight: FontWeight.w400),
        ),
        leading: BackButton(onPressed: () => {Get.toNamed('/userJourney')}),
        primary: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background_images/adventure_background.png',
                      ),
                      fit: BoxFit.cover,
                      opacity: 0.5))),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() => first = second);
                  setState(() => second = third);
                },
                onDoubleTap: () {
                  setState(() => third = Get.offAndToNamed('/ActivitiesGameScreen') as String);
                  },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    children: [
                      const Expanded(child: Text('')),
                      Stack(
                        children: [
                          Material(
                              color: Colors.transparent,
                              child: SvgPicture.asset(
                                'assets/images/talking_person.svg',
                              )),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 15, top: 10),
                            constraints: const BoxConstraints(
                                maxHeight: 150, maxWidth: 240),
                            child: Text(first,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .neutralWhite01)),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Tap to continue',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class UserJourneyModal extends StatelessWidget {
  const UserJourneyModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const UserJourneyModalWidget();
}
