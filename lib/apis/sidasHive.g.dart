// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sidasHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class sidasHiveAdapter extends TypeAdapter<sidasHive> {
  @override
  final int typeId = 1;

  @override
  sidasHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return sidasHive(
      index: fields[0] as int,
      score: fields[1] as int,
      date: fields[2] as DateTime,
      answerValues: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, sidasHive obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.score)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.answerValues);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is sidasHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
