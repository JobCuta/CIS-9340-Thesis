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

  @HiveField(3)
  String thumbnailPath;

  HopeBoxObject(
      {required this.datetime,
      required this.description,
      required this.path,
      required this.thumbnailPath});

  DateTime getDateTime() {
    return datetime;
  }

  String getDescription() {
    return description;
  }

  String getPath() {
    return path;
  }

  String getThumbnailPath() {
    return thumbnailPath;
  }

  @override
  String toString() {
    return datetime.toString() + ", " + description + ", " + path;
  }
}
