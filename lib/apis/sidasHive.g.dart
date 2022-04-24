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
      date: fields[0] as DateTime,
      answerValues: (fields[1] as List).cast<int>(),
      score: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, sidasHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.answerValues)
      ..writeByte(2)
      ..write(obj.score);
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
