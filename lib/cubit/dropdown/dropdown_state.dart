part of 'dropdown_cubit.dart';

class DropdownState {}

final class DropdownInitial extends DropdownState {}

class DropdownLoading extends DropdownState {}

class DropdownSuccess extends DropdownState {
  List<String>? data;
  List<String>? userData;
  List<Users>? users;
  String message;

  DropdownSuccess({
    this.data,
    this.userData,
    this.users,
    required this.message,
  });
}

class DropdownError extends DropdownState {
  String message;

  DropdownError(this.message);
}
