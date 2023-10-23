import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskDataModel {
  @HiveField(0)
  final String taskName;

  @HiveField(1)
  final String taskDescription;
  @HiveField(2)
  final double completePercentage;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String taskCurrentStatus;

  @HiveField(5)
  final bool isRepeat;

  TaskDataModel(this.taskName, this.taskDescription, this.completePercentage, this.date, this.taskCurrentStatus, this.isRepeat);
}
