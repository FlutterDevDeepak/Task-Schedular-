// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDataModelAdapter extends TypeAdapter<TaskDataModel> {
  @override
  final int typeId = 0;

  @override
  TaskDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskDataModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as double,
      fields[3] as DateTime,
      fields[4] as String,
      fields[5] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskDataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.taskName)
      ..writeByte(1)
      ..write(obj.taskDescription)
      ..writeByte(2)
      ..write(obj.completePercentage)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.taskCurrentStatus)
      ..writeByte(5)
      ..write(obj.isRepeat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
