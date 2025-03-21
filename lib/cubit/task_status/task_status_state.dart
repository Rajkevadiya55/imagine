part of 'task_status_cubit.dart';

sealed class TaskStatusState {}

final class TaskStatusInitial extends TaskStatusState {}

class TaskStatusLoading extends TaskStatusState {}

class TaskStatusSuccess extends TaskStatusState {
  String message;

  TaskStatusSuccess({
    required this.message,
  });
}

class TaskStatusError extends TaskStatusState {
  String message;

  TaskStatusError(this.message);
}
