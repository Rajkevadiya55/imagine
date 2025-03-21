part of 'task_list_cubit.dart';

sealed class TaskListState {}

final class TaskListInitial extends TaskListState {}

class TaskListLoading extends TaskListState {}

class TaskListSuccess extends TaskListState {
  String message;
  List<Data>? data;

  TaskListSuccess({
    required this.message,
    this.data
  });
}

class TaskListError extends TaskListState {
  String message;

  TaskListError(this.message);
}
