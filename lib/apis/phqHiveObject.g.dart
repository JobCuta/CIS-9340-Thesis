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
      index: fields[0] as int,
      score: fields[1] as int,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, phqHiveObj obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.date);
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
