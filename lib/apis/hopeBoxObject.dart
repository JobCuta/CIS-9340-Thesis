import 'package:hive/hive.dart';

part 'hopeBoxObject.g.dart';

@HiveType(typeId: 9)
class HopeBoxObject extends HiveObject {
  @HiveField(0)
  DateTime datetime;

  @HiveField(1)
  String description;

  @HiveField(2)
  String path;

  HopeBoxObject(
      {required this.datetime, required this.description, required this.path});

  DateTime getDateTime() {
    return datetime;
  }

  String getDescription() {
    return description;
  }

  String getPath() {
    return path;
  }

  @override
  String toString() {
    return datetime.toString() + ", " + description + ", " + path;
  }
}
