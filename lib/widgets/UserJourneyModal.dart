import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/screens/main/UserJourney.dart';
import 'package:flutter_application_1/widgets/talkingPersonDialog.dart';
import 'package:get/get.dart';

void main() => runApp(const UserJourneyModal());

class UserJourneyModal extends StatelessWidget {
  const UserJourneyModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const UserJourneyModalWidget();
}

class UserJourneyModalWidget extends StatefulWidget {
  const UserJourneyModalWidget({Key? key}) : super(key: key);

  @override
  State<UserJourneyModalWidget> createState() => _UserJourneyModalState();
}

class _UserJourneyModalState extends State<UserJourneyModalWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Your Adventure',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.neutralWhite01, fontWeight: FontWeight.w400),
        ),
        leading: BackButton(onPressed: () => {Get.off(UserJourneyScreen(key: 3))}),
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
                      fit: BoxFit.cover, opacity: 0.5))),
          SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
              child: showTalkingPerson(context: context, dialog: "We are here in Apayao! Welcome to level 1! In this level,")
            ),
          )
        ],
      ),
    );
  }
}