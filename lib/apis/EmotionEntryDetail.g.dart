// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmotionEntryDetail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmotionEntryDetailAdapter extends TypeAdapter<EmotionEntryDetail> {
  @override
  final int typeId = 4;

  @override
  EmotionEntryDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmotionEntryDetail(
      time: fields[0] as String,
      note: fields[1] as String,
      mood: fields[2] as String,
      positiveEmotions: (fields[3] as List).cast<dynamic>(),
      negativeEmotions: (fields[4] as List).cast<dynamic>(),
      isEmpty: fields[5] as bool,
      timeOfDay: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmotionEntryDetail obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.note)
      ..writeByte(2)
      ..write(obj.mood)
      ..writeByte(3)
      ..write(obj.positiveEmotions)
      ..writeByte(4)
      ..write(obj.negativeEmotions)
      ..writeByte(5)
      ..write(obj.isEmpty)
      ..writeByte(6)
      ..write(obj.timeOfDay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmotionEntryDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
