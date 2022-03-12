// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailyHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyHiveAdapter extends TypeAdapter<DailyHive> {
  @override
  final int typeId = 2;

  @override
  DailyHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyHive(
      currentWeekDay: fields[0] as int,
      isDailyExerciseDone: fields[1] as bool,
      isDailyEntryDone: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DailyHive obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.currentWeekDay)
      ..writeByte(1)
      ..write(obj.isDailyExerciseDone)
      ..writeByte(2)
      ..write(obj.isDailyEntryDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
