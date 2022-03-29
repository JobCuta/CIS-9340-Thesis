// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hopeBoxObject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HopeBoxObjectAdapter extends TypeAdapter<HopeBoxObject> {
  @override
  final int typeId = 9;

  @override
  HopeBoxObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HopeBoxObject(
      datetime: fields[0] as DateTime,
      description: fields[1] as String,
      path: fields[2] as String,
      thumbnailPath: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HopeBoxObject obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.datetime)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.thumbnailPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HopeBoxObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
