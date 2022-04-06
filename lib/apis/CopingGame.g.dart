// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CopingGame.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CopingGameAdapter extends TypeAdapter<CopingGame> {
  @override
  final int typeId = 12;

  @override
  CopingGame read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CopingGame(
      provinceCompleted: (fields[0] as List).cast<bool>(),
      apayaoCardsCompleted: (fields[1] as List).cast<bool>(),
      kalingaCardsCompleted: (fields[2] as List).cast<bool>(),
      abraCardsCompleted: (fields[3] as List).cast<bool>(),
      mountainProvinceCardsCompleted: (fields[4] as List).cast<bool>(),
      ifugaoCardsCompleted: (fields[5] as List).cast<bool>(),
      benguetCardsCompleted: (fields[6] as List).cast<bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, CopingGame obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.provinceCompleted)
      ..writeByte(1)
      ..write(obj.apayaoCardsCompleted)
      ..writeByte(2)
      ..write(obj.kalingaCardsCompleted)
      ..writeByte(3)
      ..write(obj.abraCardsCompleted)
      ..writeByte(4)
      ..write(obj.mountainProvinceCardsCompleted)
      ..writeByte(5)
      ..write(obj.ifugaoCardsCompleted)
      ..writeByte(6)
      ..write(obj.benguetCardsCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CopingGameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
