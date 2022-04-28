// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MemoryGame.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MemoryGameAdapter extends TypeAdapter<MemoryGame> {
  @override
  final int typeId = 13;

  @override
  MemoryGame read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MemoryGame(
      provinceCompleted: (fields[0] as List).cast<bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, MemoryGame obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.provinceCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MemoryGameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
