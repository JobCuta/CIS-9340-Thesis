import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/adventureController.dart';
import 'package:flutter_application_1/enums/Province.dart';
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
  final AdventureController _adventureController = Get.put(AdventureController());
  String first ='';
  String second ='';
  String third ='';

  @override
  Widget build(BuildContext context) {
    Province selectedProvince = _adventureController.selectedProvince.value;

    if (selectedProvince == Province.Apayao) {
      first = "Hello! Welcome to your Adventure. On each level, I will be sharing knowledge about mental health.";
      second = "Play the activities to unlock more levels and awards. The minigames tab contains quick games you can play.";
      third = "Welcome to Level 1: Apayao. Did you know that Apayao is the only province in Cordillera that can be travelled by using boats and rafts on water amidst being a mountainous region.";
    } else if (selectedProvince == Province.Kalinga) {
      second = "Play the activities to unlock more levels and awards. The minigames tab contains quick games you can play.";
      third = "Welcome to Level 2: Kalinga. Did you know that Kalinga is was only made an official province back in 1992 under the RA 7878.";
    } else if (selectedProvince == Province.Abra) {
      second = "Play the activities to unlock more levels and awards. The minigames tab contains quick games you can play.";
      third = "Welcome to Level 3: Abra. This province is most known for its Abel fabrics, horses and the famous Abra River.";
    } else if (selectedProvince == Province.MountainProvince) {
      second = "Play the activities to unlock more levels and awards. The minigames tab contains quick games you can play.";
      third = "Welcome to Level 4: Mt. Province. Did you know that Mt. Province was also known as 'La Montanosa' by the Spanish government for its mountainous landscapes. The province is located in the heart of the Cordillera Region.";
    } else if (selectedProvince == Province.Ifugao) {
      second = "Play the activities to unlock more levels and awards. The minigames tab contains quick games you can play.";
      third = "Welcome to Level 5: Ifugao. Back in 1995, the Rice Terraces of the Philippines which was located in Ifugao was declared as one of UNESCO's World Heritage Sites.";
    } else if (selectedProvince == Province.Benguet) {
      second = "Play the activities to unlock more levels and awards. The minigames tab contains quick games you can play.";
      third = "Welcome to Level 6: Benguet. Did you know that Benguet is also known as the 'Salad Bowl of the Philippines' for its massive production of upland vegetables.";
    }
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
