// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Level.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LevelAdapter extends TypeAdapter<Level> {
  @override
  final int typeId = 7;

  @override
  Level read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Level(
      currentLevel: fields[0] as int,
      currentXp: fields[1] as int,
      xpForNextLevel: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Level obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currentLevel)
      ..writeByte(1)
      ..write(obj.currentXp)
      ..writeByte(2)
      ..write(obj.xpForNextLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LevelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
