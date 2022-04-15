import 'package:hive/hive.dart';
part 'phqHive.g.dart';

@HiveType(typeId: 0)
class phqHive extends HiveObject {
  @HiveField(0, defaultValue: '')
  String schedule;

  @HiveField(1, defaultValue: 0)
  int assessment1;

  @HiveField(2, defaultValue: 0)
  int assessment2;

  @HiveField(3, defaultValue: -1)
  int score1;

    @HiveField(4, defaultValue: -1)
  int score2;

  phqHive({
    required this.schedule,
    required this.assessment1,
    required this.assessment2,
    required this.score1,
    required this.score2,
  });
}
