import 'package:hive/hive.dart';

part 'ContactDetails.g.dart';

@HiveType(typeId: 10)
class ContactDetails extends HiveObject {
  @HiveField(0)
  String pathImage;

  @HiveField(1)
  String firstName;

  @HiveField(2)
  String lastName;

  @HiveField(3)
  String mobileNumber;

  @HiveField(4)
  String message;

  ContactDetails(
      {required this.pathImage,
      required this.firstName,
      required this.lastName,
      required this.mobileNumber,
      required this.message});

  String getPathImage() {
    return pathImage;
  }

  String getFirstName() {
    return firstName;
  }

  String getLastName() {
    return lastName;
  }

  String getMobileNumber() {
    return mobileNumber;
  }

  String getMessage() {
    return message;
  }

  @override
  String toString() {
    return firstName +
        ", " +
        lastName +
        ", " +
        mobileNumber +
        ", " +
        pathImage +
        ', ' +
        message;
  }
}
