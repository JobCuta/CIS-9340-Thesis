import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background_images/achievements_background.png'),
                      fit: BoxFit.cover))),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 36, 8, 10),
              child: Column(
                children: [
                  const SizedBox(height: 36),
                  const Image(
                    image: AssetImage('assets/images/user_avatar.png'), width: 328, height: 148,
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 3.0, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text('Achievements', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24.0, color: Color.fromRGBO(237, 172, 5, 1))),
                  const SizedBox(height: 10),
                  Container(
                    height: 132, width: MediaQuery.of(context).size.width - 32,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Current Level:' + ' Level 1',
                            style: TextStyle(
                              color: Color.fromRGBO(255, 193, 34, 1),
                              fontSize: 20.0, fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            width: MediaQuery.of(context).size.width - 82, height: 11,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 190, 24, 1),
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text('19000' + ' / ' + '20000' + ' to unlock next level',
                            style: TextStyle(fontSize: 14.0),
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              Text('Continue Adventure', style: const TextStyle(fontSize: 16.0)),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width - 216,
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text('Go', style: TextStyle(fontSize: 16.0, color: Color.fromRGBO(172, 178, 180, 1), fontWeight: FontWeight.bold),),
                                        Icon(Icons.chevron_right, color: Color.fromRGBO(172, 178, 180, 1), size: 25,)
                                      ])
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      achievementContainers('assets/achievements/apayao_adventure_achievements.png', 'General Achievements', '40', '60'),
                      achievementContainers('assets/achievements/apayao_adventure_achievements.png', 'Apayao Adventure', '10', '10')
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      achievementContainers('assets/achievements/kalinga_adventure_achievements.png', 'Kalinga Adventure', '5', '10'),
                      achievementContainers('assets/achievements/abra_adventure_achievements.png', 'Abra Adventure', '7', '10'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      achievementContainers('assets/achievements/abra_adventure_achievements.png', 'Mt. Province Adventure', '9', '10'),
                      achievementContainers('assets/achievements/ifugao_adventure_achievements.png', 'Ifugao Adventure', '1', '10'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      achievementContainers('assets/achievements/benguet_adventure_achievements.png', 'Benguet Adventure', '5', '10'),
                      achievementContainers('assets/achievements/warrior_adventure_achievements.png', 'Mini Games Warrior', '3', '10'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  achievementContainers(path, String title, String noOfCurrAchievements, String noOfTotalAchievements) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2509, width: MediaQuery.of(context).size.width * 0.4611 -5,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0)
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset (path, height: 60, width: 60),
            const SizedBox(height: 6.0),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12.0)),
            const SizedBox(height: 6.0),
            expBar(),
            const SizedBox(height: 6.0),
            Text(noOfCurrAchievements + ' out of ' + noOfTotalAchievements)
          ],
        ),
      ),
    );
  }

  expBar() {
    return Container(
      width: 110, height: 9,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(76, 154, 42, 1),
          borderRadius: BorderRadius.circular(20)
      ),
    );
  }
}