import 'package:hydrated_bloc/hydrated_bloc.dart';

class CreateTaskHydratedStorageCubit extends HydratedCubit<bool?> {
  CreateTaskHydratedStorageCubit() : super(null);

  setBool(bool status) => emit(status);
  clearData() => emit(null);

  @override
  bool? fromJson(Map<String, dynamic> json) => json['value'] as bool;

  @override
  Map<String, dynamic>? toJson(bool? state) => { 'value': state };
}
