import 'package:flutter/cupertino.dart';

class Mood {
  String name;
  AssetImage icon;

  Mood({required this.name, required this.icon});
}


Map<String, Mood> moodMap = {
  'VeryHappy' :  Mood(name: 'VeryHappy', icon: const AssetImage('assets/images/face_very_happy_selected.png')),
  'VeryHappyNotSelected' : Mood(name: 'VeryHappy', icon: const AssetImage('assets/images/face_very_happy.png')),
  'Happy' : Mood(name: 'Happy', icon: const AssetImage('assets/images/face_happy_selected.png')),
  'HappyNotSelected' : Mood(name: 'Happy', icon: const AssetImage('assets/images/face_happy.png')),
  'Neutral' : Mood(name: 'Neutral', icon: const AssetImage('assets/images/face_neutral_selected.png')),
  'NeutralNotSelected' : Mood(name: 'Neutral', icon: const AssetImage('assets/images/face_neutral.png')),
  'Bad' : Mood(name: 'Bad', icon: const AssetImage('assets/images/face_bad_selected.png')),
  'BadNotSelected' : Mood(name: 'Bad', icon: const AssetImage('assets/images/face_bad.png')),
  'VeryBad' : Mood(name: 'VeryBad', icon: const AssetImage('assets/images/face_very_bad_selected.png')),
  'VeryBadNotSelected' : Mood(name: 'VeryBad', icon: const AssetImage('assets/images/face_very_bad.png')),
  'NoData' : Mood(name: 'NoData', icon: const AssetImage('assets/images/face_empty.png')),

};

