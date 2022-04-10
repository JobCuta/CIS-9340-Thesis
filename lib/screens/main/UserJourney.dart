import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/controllers/levelController.dart';
import 'package:get/get.dart';

class UserJourneyScreen extends StatefulWidget {
  const UserJourneyScreen({key}) : super(key: key);

  @override
  State<UserJourneyScreen> createState() => _UserJourneyScreenState();
}

class _UserJourneyScreenState extends State<UserJourneyScreen>{
  LevelController _levelController = Get.put(LevelController());

  @override
  Widget build(BuildContext context) {
    int currentLevel = _levelController.currentLevel.value;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Your Adventure',
          style: Theme.of(context).textTheme.subtitle2?.copyWith(
              color: Theme.of(context).colorScheme.neutralWhite01,
              fontWeight: FontWeight.w400),
        ),
        leading: BackButton(onPressed: () => {Get.offAndToNamed('/adventureHome')}),
        primary: true,
        elevation: 0,
        backgroundColor: const Color(0xff216CB2).withOpacity(0.40),
      ),
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/background_images/adventure_background.png',),
                      fit: BoxFit.cover))),
          SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          // Get.toNamed('');
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/Apayao.png'),
                              fit: BoxFit.cover,
                              opacity: 0.7
                            ),
                          ),
                          width: 328,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Apayao',
                                  style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  'Level 1',
                                  style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),

                      InkWell(
                        onTap: () {
                          // Get.toNamed('');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currentLevel < 2 ? Colors.black : Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage('assets/images/Kalinga.png'),
                              fit: BoxFit.cover,
                              opacity: currentLevel < 2 ? 0.5 : 0.7,
                            ),
                          ),
                          width: 328,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kalinga',
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                    ),
                                    const SizedBox(height: 5.0),
                                    Visibility(
                                      visible: currentLevel >= 2,
                                      child: Text(
                                        'Level 2',
                                        style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                      ),
                                    ),
                                  ],
                                ),

                                Visibility(
                                  visible: currentLevel < 2,
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'You need to be',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Level 2 to unlock',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                        ],
                                      ),

                                      const Icon(Icons.lock),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      InkWell(
                        onTap: () {
                          // Get.toNamed('');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currentLevel < 3 ? Colors.black : Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage('assets/images/Abra.png'),
                              fit: BoxFit.cover,
                              opacity: currentLevel < 3 ? 0.5 : 0.7,
                            ),
                          ),
                          width: 328,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Abra',
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                    ),
                                    const SizedBox(height: 5.0),
                                    Visibility(
                                      visible: currentLevel >= 3,
                                      child: Text(
                                        'Level 3',
                                        style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                      ),
                                    ),
                                  ],
                                ),

                                Visibility(
                                  visible: currentLevel < 3,
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'You need to be',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Level 3 to unlock',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                        ],
                                      ),

                                      const Icon(Icons.lock),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                                            InkWell(
                        onTap: () {
                          // Get.toNamed('');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currentLevel < 4 ? Colors.black : Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage('assets/images/Mt Province.png'),
                              fit: BoxFit.cover,
                              opacity: currentLevel < 4 ? 0.5 : 0.7,
                            ),
                          ),
                          width: 328,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mt. Province',
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                    ),
                                    const SizedBox(height: 5.0),
                                    Visibility(
                                      visible: currentLevel >= 4,
                                      child: Text(
                                        'Level 4',
                                        style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                      ),
                                    ),
                                  ],
                                ),

                                Visibility(
                                  visible: currentLevel < 4,
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'You need to be',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Level 4 to unlock',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                        ],
                                      ),

                                      const Icon(Icons.lock),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                                            InkWell(
                        onTap: () {
                          // Get.toNamed('');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currentLevel < 5 ? Colors.black : Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage('assets/images/Ifugao.png'),
                              fit: BoxFit.cover,
                              opacity: currentLevel < 5 ? 0.5 : 0.7,
                            ),
                          ),
                          width: 328,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ifugao',
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                    ),
                                    const SizedBox(height: 5.0),
                                    Visibility(
                                      visible: currentLevel >= 5,
                                      child: Text(
                                        'Level 5',
                                        style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                      ),
                                    ),
                                  ],
                                ),

                                Visibility(
                                  visible: currentLevel < 5,
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'You need to be',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Level 5 to unlock',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                        ],
                                      ),

                                      const Icon(Icons.lock),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      InkWell(
                        onTap: () {
                          // Get.toNamed('');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: currentLevel < 6 ? Colors.black : Colors.transparent,
                            image: DecorationImage(
                              image: AssetImage('assets/images/Benguet.png'),
                              fit: BoxFit.cover,
                              opacity: currentLevel < 6 ? 0.5 : 0.7,
                            ),
                          ),
                          width: 328,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Benguet',
                                      style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                    ),
                                    const SizedBox(height: 5.0),
                                    Visibility(
                                      visible: currentLevel >= 6,
                                      child: Text(
                                        'Level 6',
                                        style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                      ),
                                    ),
                                  ],
                                ),

                                Visibility(
                                  visible: currentLevel < 6,
                                  child: Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'You need to be',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                          const SizedBox(height: 5.0),
                                          Text(
                                            'Level 6 to unlock',
                                            style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.neutralWhite01)
                                          ),
                                        ],
                                      ),

                                      const Icon(Icons.lock),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  )
                  ),
              ),
              )
        ],
      )
    );
  }

}