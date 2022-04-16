import 'package:flutter_application_1/apis/phqHiveObject.dart';
import 'package:hive/hive.dart';
part 'phqHive.g.dart';

@HiveType(typeId: 0)
class phqHive extends HiveObject {
  @HiveField(0)
  List<phqHiveObj> assessments;

  List<phqHiveObj> getAssessments() {
    return assessments;
  }

  phqHive({
    required this.assessments,
  });
}
