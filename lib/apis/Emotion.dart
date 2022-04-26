import 'package:hive/hive.dart';

part 'Emotion.g.dart';

@HiveType(typeId: 5)
class Emotion extends HiveObject {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Emotion &&
          runtimeType == other.runtimeType &&
          name == other.name;
}
