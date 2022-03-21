// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settingsHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsHiveAdapter extends TypeAdapter<SettingsHive> {
  @override
  final int typeId = 6;

  @override
  SettingsHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsHive(
      notificationsEnabled: fields[0] as bool,
      notificationsMorningTime: fields[1] as TimeOfDay,
      notificationsAfternoonTime: fields[2] as TimeOfDay,
      notificationsEveningTime: fields[3] as TimeOfDay,
      language: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.notificationsEnabled)
      ..writeByte(1)
      ..write(obj.notificationsMorningTime)
      ..writeByte(2)
      ..write(obj.notificationsAfternoonTime)
      ..writeByte(3)
      ..write(obj.notificationsEveningTime)
      ..writeByte(4)
      ..write(obj.language);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
