part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

final class TaskLoading extends TaskState {}

final class TaskSuccess extends TaskState {
  final List<TaskModel> task;

  const TaskSuccess({required this.task});

  @override
  List<Object> get props => [
    task
  ];
}



final class TaskError extends TaskState {
  final String error;

  const TaskError({required this.error});

  @override
  List<Object> get props => [
    error
  ];
}
