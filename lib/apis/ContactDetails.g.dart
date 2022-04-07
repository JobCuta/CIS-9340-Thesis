// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ContactDetails.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContactDetailsAdapter extends TypeAdapter<ContactDetails> {
  @override
  final int typeId = 10;

  @override
  ContactDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ContactDetails(
      pathImage: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      mobileNumber: fields[3] as String,
      message: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ContactDetails obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.pathImage)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.mobileNumber)
      ..writeByte(4)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
