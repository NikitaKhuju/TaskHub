// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      fields[0] as String,
      fields[1] as bool,
      fields[2] as DateTime,
      fields[3] as String,
      fields[4] as String,
      fields[5] as TimeOfDay,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.taskCompleted)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.taskNote)
      ..writeByte(4)
      ..write(obj.taskPriority)
      ..writeByte(5)
      ..write(obj.taskTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
