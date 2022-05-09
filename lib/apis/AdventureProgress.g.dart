// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AdventureProgress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdventureProgressAdapter extends TypeAdapter<AdventureProgress> {
  @override
  final int typeId = 12;

  @override
  AdventureProgress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdventureProgress(
      memoryProvinceCompleted: (fields[0] as List).cast<bool>(),
      sudokuProvinceCompleted: (fields[1] as List).cast<bool>(),
      copingProvinceCompleted: (fields[2] as List).cast<bool>(),
      apayaoCardsCompleted: (fields[3] as List).cast<bool>(),
      kalingaCardsCompleted: (fields[4] as List).cast<bool>(),
      abraCardsCompleted: (fields[5] as List).cast<bool>(),
      mountainProvinceCardsCompleted: (fields[6] as List).cast<bool>(),
      ifugaoCardsCompleted: (fields[7] as List).cast<bool>(),
      benguetCardsCompleted: (fields[8] as List).cast<bool>(),
      miniGamesWarrior: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, AdventureProgress obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.memoryProvinceCompleted)
      ..writeByte(1)
      ..write(obj.sudokuProvinceCompleted)
      ..writeByte(2)
      ..write(obj.copingProvinceCompleted)
      ..writeByte(3)
      ..write(obj.apayaoCardsCompleted)
      ..writeByte(4)
      ..write(obj.kalingaCardsCompleted)
      ..writeByte(5)
      ..write(obj.abraCardsCompleted)
      ..writeByte(6)
      ..write(obj.mountainProvinceCardsCompleted)
      ..writeByte(7)
      ..write(obj.ifugaoCardsCompleted)
      ..writeByte(8)
      ..write(obj.benguetCardsCompleted)
      ..writeByte(9)
      ..write(obj.miniGamesWarrior);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdventureProgressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
