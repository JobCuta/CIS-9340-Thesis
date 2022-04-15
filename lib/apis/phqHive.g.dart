// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phqHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class phqHiveAdapter extends TypeAdapter<phqHive> {
  @override
  final int typeId = 0;

  @override
  phqHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return phqHive(
      schedule: fields[0] == null ? '' : fields[0] as String,
      assessment1: fields[1] == null ? 0 : fields[1] as int,
      assessment2: fields[2] == null ? 0 : fields[2] as int,
      score1: fields[3] == null ? -1 : fields[3] as int,
      score2: fields[4] == null ? -1 : fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, phqHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.schedule)
      ..writeByte(1)
      ..write(obj.assessment1)
      ..writeByte(2)
      ..write(obj.assessment2)
      ..writeByte(3)
      ..write(obj.score1)
      ..writeByte(4)
      ..write(obj.score2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is phqHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
