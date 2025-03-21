part of 'create_task_cubit.dart';

sealed class CreateTaskState {}

final class CreateTaskInitial extends CreateTaskState {}
class CreateTaskLoading extends CreateTaskState {}

class CreateTaskSuccess extends CreateTaskState {
  String message;

  CreateTaskSuccess({
    required this.message,
  });
}

class CreateTaskError extends CreateTaskState {
  String message;

  CreateTaskError(this.message);
}
