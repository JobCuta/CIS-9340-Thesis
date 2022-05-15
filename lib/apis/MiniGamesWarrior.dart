import 'package:hive/hive.dart';

part 'MiniGamesWarrior.g.dart';

@HiveType(typeId: 14)
class MiniGamesWarrior extends HiveObject{
  @HiveField(0)
  int mgw;

  MiniGamesWarrior({
    required this.mgw
  });
}