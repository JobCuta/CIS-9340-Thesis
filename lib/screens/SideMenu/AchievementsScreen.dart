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
              padding: const EdgeInsets.fromLTRB(10, 36, 10, 10),
              child: Column(
                children: [
                  const Image(
                    image: AssetImage('assets/images/user_avatar.png'), width: 328, height: 148,
                  ),
                  const SizedBox(height: 10),
                  const Divider(height: 1.0),
                  const SizedBox(height: 10),
                  Text('Achievements', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24.0, color: Color.fromRGBO(237, 172, 5, 1))),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 132, width: 340,
                  ),
                  Row(
                    children: [
                      achievementContainers('assets/achievements/apayao_adventure_achievements.png', 'General Achievements', '40', '60'),
                      achievementContainers('assets/achievements/apayao_adventure_achievements.png', 'Apayao Adventure', '10', '10')
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      achievementContainers('assets/achievements/kalinga_adventure_achievements.png', 'Kalinga Adventure', '5', '10'),
                      achievementContainers('assets/achievements/abra_adventure_achievements.png', 'Abra Adventure', '7', '10'),
                    ],
                  ),
                  Row(
                    children: [
                      achievementContainers('assets/achievements/abra_adventure_achievements.png', 'Mt. Province Adventure', '9', '10'),
                      achievementContainers('assets/achievements/ifugao_adventure_achievements.png', 'Ifugao Adventure', '1', '10'),
                    ],
                  ),
                  Row(
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
      height: 141, width: 166,
      decoration: const BoxDecoration(color: Colors.white),
      child: Center(
        child: Column(
          children: [
            Image.asset (path, height: 60, width: 60),
            const SizedBox(height: 6.0),
            Text(title),
            const SizedBox(height: 6.0),
            Text(noOfCurrAchievements + ' out of ' + noOfTotalAchievements)
          ],
        ),
      ),
    );
  }
}