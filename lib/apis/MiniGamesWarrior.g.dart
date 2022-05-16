// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MiniGamesWarrior.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MiniGamesWarriorAdapter extends TypeAdapter<MiniGamesWarrior> {
  @override
  final int typeId = 14;

  @override
  MiniGamesWarrior read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MiniGamesWarrior(
      mgw: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MiniGamesWarrior obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.mgw);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MiniGamesWarriorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
