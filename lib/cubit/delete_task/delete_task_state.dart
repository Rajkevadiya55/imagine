part of 'delete_task_cubit.dart';

@immutable
sealed class DeleteTaskState {}

final class DeleteTaskInitial extends DeleteTaskState {}
class DeleteTaskLoading extends DeleteTaskState {}

class DeleteTaskSuccess extends DeleteTaskState {
  String message;

  DeleteTaskSuccess({
    required this.message,
  });
}

class DeleteTaskError extends DeleteTaskState {
  String message;

  DeleteTaskError(this.message);
}