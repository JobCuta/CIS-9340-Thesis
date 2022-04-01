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
      currentDate: fields[1] as DateTime,
      isDailyExerciseDone: fields[2] as bool,
      isDailyEntryDone: fields[3] as bool,
      showedAvailableTasks: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, DailyHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.currentWeekDay)
      ..writeByte(1)
      ..write(obj.currentDate)
      ..writeByte(2)
      ..write(obj.isDailyExerciseDone)
      ..writeByte(3)
      ..write(obj.isDailyEntryDone)
      ..writeByte(4)
      ..write(obj.showedAvailableTasks);
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
