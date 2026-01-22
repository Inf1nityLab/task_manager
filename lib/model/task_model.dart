
import 'package:isar/isar.dart';
part 'task_model.g.dart';

@collection
class TaskModel {
  Id  id = Isar.autoIncrement;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  final int priority;
  final String categoryId;
  final DateTime createdAt;

  TaskModel({
    this.id = Isar.autoIncrement,
    required this.title,
    this.description = '',
    required this.dueDate,
    this.isCompleted = false,
    this.priority = 0,
    required this.categoryId,
    required this.createdAt,
  });


  TaskModel copyWith({
    Id? id,
    String? title,
    String? description,
    bool? isCompleted,
    int? priority,
    DateTime? dueDate,
  }) {
    return TaskModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        priority: priority ?? this.priority,
        isCompleted: isCompleted ?? this.isCompleted,
        categoryId: this.categoryId,
        createdAt: this.createdAt);
  }
}







