// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phqHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class phqHiveAdapter extends TypeAdapter<phqHive> {
  @override
  final int typeId = 0;

  @override
  phqHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return phqHive(
      date: fields[0] as DateTime,
      answerValues: (fields[1] as List).cast<int>(),
      sum: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, phqHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.answerValues)
      ..writeByte(2)
      ..write(obj.sum);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is phqHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
