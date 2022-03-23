import 'package:hive/hive.dart';

part 'Level.g.dart';

@HiveType(typeId: 6)
class Level extends HiveObject{
  @HiveField(0)
  int currentLevel;

  @HiveField(1)
  int currentXp;

  @HiveField(2)
  int xpForNextLevel;

  Level({
    required this.currentLevel,
    required this.currentXp,
    required this.xpForNextLevel,
  });
}