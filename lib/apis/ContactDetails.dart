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

  ContactDetails({
    required this.pathImage,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
  });

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

  @override
  String toString() {
    return firstName + ", " + lastName + ", " + mobileNumber + ", " + pathImage;
  }
}
