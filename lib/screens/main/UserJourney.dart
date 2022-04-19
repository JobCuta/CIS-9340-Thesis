import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:flutter_application_1/screens/main/HomepageScreen.dart';
import 'package:get/get.dart';

import '../../widgets/UserJourneyModal.dart';

class UserJourneyScreen extends StatefulWidget {
  const UserJourneyScreen({key}) : super(key: key);

  @override
  State<UserJourneyScreen> createState() => _UserJourneyScreenState();
}

class _UserJourneyScreenState extends State<UserJourneyScreen> {
  final LevelController _levelController = Get.put(LevelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'Your Adventure',
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color: Theme.of(context).colorScheme.neutralWhite01,
                fontWeight: FontWeight.w400),
          ),
          leading: BackButton(onPressed: () => {Get.off(HomePageScreen(3))}),
          primary: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/background_images/adventure_background.png',
                        ),
                        fit: BoxFit.cover))),
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 25),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        _buildLevelComponent(
                          title: 'Apayao',
                          requiredLevel: 1,
                          image: 'assets/images/Apayao.png',
                          onTap: () {
                            Get.off(const UserJourneyModalWidget());
                          },
                        ),
                        _buildLevelComponent(
                          title: 'Kalinga',
                          requiredLevel: 2,
                          image: 'assets/images/Kalinga.png',
                          onTap: () {
                            Get.off(const UserJourneyModalWidget());
                          },
                        ),
                        _buildLevelComponent(
                          title: 'Abra',
                          requiredLevel: 3,
                          image: 'assets/images/Abra.png',
                          onTap: () {
                            Get.off(const UserJourneyModalWidget());
                          },
                        ),
                        _buildLevelComponent(
                          title: 'Mt. Province',
                          requiredLevel: 4,
                          image: 'assets/images/Mt Province.png',
                          onTap: () {
                            Get.off(const UserJourneyModalWidget());
                          },
                        ),
                        _buildLevelComponent(
                          title: 'Ifugao',
                          requiredLevel: 5,
                          image: 'assets/images/Ifugao.png',
                          onTap: () {
                            Get.off(const UserJourneyModalWidget());
                          },
                        ),
                        _buildLevelComponent(
                          title: 'Benguet',
                          requiredLevel: 6,
                          image: 'assets/images/Benguet.png',
                          onTap: () {
                            Get.off(const UserJourneyModalWidget());
                          },
                        ),
                      ],
                    )),
              ),
            )
          ],
        ));
  }

  _buildLevelComponent({title, requiredLevel, image, onTap}) {
    int currentLevel = _levelController.currentLevel.value;

    return InkWell(
      onTap: currentLevel >= requiredLevel ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color:
              currentLevel < requiredLevel ? Colors.black : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            opacity: currentLevel < requiredLevel ? 0.2 : 1,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              gradient: currentLevel >= requiredLevel
                  ? LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xffFF9B25).withOpacity(0.6),
                        Colors.transparent,
                      ],
                    )
                  : null),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01)),
                      const SizedBox(height: 5.0),
                      Visibility(
                        visible: currentLevel >= requiredLevel,
                        child: Text('Level $requiredLevel',
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .neutralWhite01)),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: currentLevel < requiredLevel,
                  child: Row(
                    children: [
                      Text('You need to be\nLevel $requiredLevel to unlock',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(
                                  height: 1.5,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .neutralWhite01)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.lock_outline,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
