import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/enums/MoodEnum.dart';

class Mood {
  MoodEnum name;
  AssetImage icon;

  Mood({required this.name, required this.icon});
}