import 'package:hive/hive.dart';

part 'MemoryGame.g.dart';

@HiveType(typeId: 13)
class MemoryGame extends HiveObject{
  @HiveField(0)
  List<bool> provinceCompleted;

  MemoryGame({
    required this.provinceCompleted,
  });
}