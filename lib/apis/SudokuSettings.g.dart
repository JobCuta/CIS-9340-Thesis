// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SudokuSettings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SudokuSettingsAdapter extends TypeAdapter<SudokuSettings> {
  @override
  final int typeId = 11;

  @override
  SudokuSettings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SudokuSettings(
      currentDifficultyLevel: fields[0] as String,
      currentTheme: fields[1] as String,
      currentAccentColor: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SudokuSettings obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currentDifficultyLevel)
      ..writeByte(1)
      ..write(obj.currentTheme)
      ..writeByte(2)
      ..write(obj.currentAccentColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SudokuSettingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
