import 'package:flutter/cupertino.dart';

class Mood {
  MoodEnum name;
  bool isSelected;
  AssetImage icon;

  Mood({required this.name, required this.isSelected, required this.icon});
}


enum MoodEnum {
  VeryBad,
  Bad,
  Neutral,
  Happy,
  VeryHappy
}


Mood veryHappySelected = Mood(name: MoodEnum.VeryHappy, isSelected: true, icon: const AssetImage('assets/images/face_very_happy_selected.png'));
Mood veryHappyNotSelected = Mood(name: MoodEnum.VeryHappy, isSelected: false, icon: const AssetImage('assets/images/face_very_happy.png'));
Mood happySelected = Mood(name: MoodEnum.Happy, isSelected: true, icon: const AssetImage('assets/images/face_happy_selected.png'));
Mood happyNotSelected = Mood(name: MoodEnum.Happy, isSelected: false, icon: const AssetImage('assets/images/face_happy.png'));
Mood neutralSelected = Mood(name: MoodEnum.Neutral, isSelected: true, icon: const AssetImage('assets/images/face_neutral_selected.png'));
Mood neutralNotSelected = Mood(name: MoodEnum.Neutral, isSelected: false, icon: const AssetImage('assets/images/face_neutral.png'));
Mood badSelected = Mood(name: MoodEnum.Bad, isSelected: true, icon: const AssetImage('assets/images/face_bad_selected.png'));
Mood badNotSelected = Mood(name: MoodEnum.Bad, isSelected: false, icon: const AssetImage('assets/images/face_bad.png'));
Mood veryBadSelected = Mood(name: MoodEnum.VeryBad, isSelected: true, icon: const AssetImage('assets/images/face_very_bad_selected.png'));
Mood veryBadNotSelected = Mood(name: MoodEnum.VeryBad, isSelected: false, icon: const AssetImage('assets/images/face_very_bad.png'));
