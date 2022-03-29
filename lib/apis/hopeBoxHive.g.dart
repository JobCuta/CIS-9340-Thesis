// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hopeBoxHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HopeBoxAdapter extends TypeAdapter<HopeBox> {
  @override
  final int typeId = 8;

  @override
  HopeBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HopeBox(
      images: (fields[0] as List).cast<HopeBoxObject>(),
      videos: (fields[1] as List).cast<HopeBoxObject>(),
      recordings: (fields[2] as List).cast<HopeBoxObject>(),
    );
  }

  @override
  void write(BinaryWriter writer, HopeBox obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.images)
      ..writeByte(1)
      ..write(obj.videos)
      ..writeByte(2)
      ..write(obj.recordings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HopeBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
