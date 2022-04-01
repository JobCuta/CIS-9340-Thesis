import 'package:flutter_application_1/apis/hopeBoxObject.dart';
import 'package:flutter_application_1/apis/ContactDetails.dart';

import 'package:hive/hive.dart';

part 'hopeBoxHive.g.dart';

@HiveType(typeId: 8)
class HopeBox extends HiveObject {
  @HiveField(0)
  List<HopeBoxObject> images;

  @HiveField(1)
  List<HopeBoxObject> videos;

  @HiveField(2)
  List<HopeBoxObject> recordings;

  @HiveField(3)
  ContactDetails contactPerson;

  HopeBox({
    required this.images,
    required this.videos,
    required this.recordings,
    required this.contactPerson,
  });
}
