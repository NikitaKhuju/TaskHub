import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  bool taskCompleted = false;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String taskNote;

  @HiveField(4)
  String taskPriority;

  @HiveField(5)
  TimeOfDay taskTime;

  Task(this.taskName, this.taskCompleted, this.date, this.taskNote,
      this.taskPriority, this.taskTime);
}
