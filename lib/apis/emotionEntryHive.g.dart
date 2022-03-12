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
      overallMood: fields[0] as Mood,
      weekday: fields[1] as String,
      date: fields[2] as String,
      morningCheck: (fields[3] as Map).cast<String, Mood>(),
      afternoonCheck: (fields[4] as Map).cast<String, Mood>(),
      eveningCheck: (fields[5] as Map).cast<String, Mood>(),
    );
  }

  @override
  void write(BinaryWriter writer, EmotionEntryHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.overallMood)
      ..writeByte(1)
      ..write(obj.weekday)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.morningCheck)
      ..writeByte(4)
      ..write(obj.afternoonCheck)
      ..writeByte(5)
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
