// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phqHiveObject.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class phqHiveObjAdapter extends TypeAdapter<phqHiveObj> {
  @override
  final int typeId = 13;

  @override
  phqHiveObj read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return phqHiveObj(
      date: fields[0] as DateTime,
      score: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, phqHiveObj obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.score);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is phqHiveObjAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
