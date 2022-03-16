import 'package:hive/hive.dart';

part 'Emotion.g.dart';

@HiveType(typeId: 5)
class Emotion extends HiveObject{
  @HiveField(0)
  int id;

  @HiveField(1)
  String name;

  Emotion({
    required this.id,
    required this.name,
  });

  @override
  toString() => name;
}