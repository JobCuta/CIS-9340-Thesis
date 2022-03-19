// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotionEntryHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmotionEntryHiveAdapter extends TypeAdapter<EmotionEntryHive> {
  @override
  final int typeId = 3;

  @override
  EmotionEntryHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmotionEntryHive(
      overallMood: fields[0] as String,
      weekday: fields[1] as String,
      month: fields[2] as String,
      day: fields[3] as int,
      year: fields[4] as int,
      morningCheck: fields[5] as EmotionEntryDetail,
      afternoonCheck: fields[6] as EmotionEntryDetail,
      eveningCheck: fields[7] as EmotionEntryDetail,
    );
  }

  @override
  void write(BinaryWriter writer, EmotionEntryHive obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.overallMood)
      ..writeByte(1)
      ..write(obj.weekday)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.year)
      ..writeByte(5)
      ..write(obj.morningCheck)
      ..writeByte(6)
      ..write(obj.afternoonCheck)
      ..writeByte(7)
      ..write(obj.eveningCheck);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmotionEntryHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
