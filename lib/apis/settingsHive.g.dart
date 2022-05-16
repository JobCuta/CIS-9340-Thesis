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
      notificationsMorningTime: (fields[1] as List).cast<String>(),
      notificationsAfternoonTime: (fields[2] as List).cast<String>(),
      notificationsEveningTime: (fields[3] as List).cast<String>(),
      language: fields[4] as String,
      imagePath: fields[5] as String,
      framePath: fields[6] as String,
      phqNotificationsEnabled: fields[7] as bool,
      sidasNotificationsEnabled: fields[8] as bool,
      notifID: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsHive obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.notificationsEnabled)
      ..writeByte(1)
      ..write(obj.notificationsMorningTime)
      ..writeByte(2)
      ..write(obj.notificationsAfternoonTime)
      ..writeByte(3)
      ..write(obj.notificationsEveningTime)
      ..writeByte(4)
      ..write(obj.language)
      ..writeByte(5)
      ..write(obj.imagePath)
      ..writeByte(6)
      ..write(obj.framePath)
      ..writeByte(7)
      ..write(obj.phqNotificationsEnabled)
      ..writeByte(8)
      ..write(obj.sidasNotificationsEnabled)
      ..writeByte(9)
      ..write(obj.notifID);
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
