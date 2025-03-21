import 'package:hydrated_bloc/hydrated_bloc.dart';

class UserIdHydratedStorageCubit extends HydratedCubit<String?> {
  UserIdHydratedStorageCubit() : super(null);

  setString(String id) => emit(id);
  clearData() => emit(null);

  @override
  String? fromJson(Map<String, dynamic> json) => json['value'] as String;

  @override
  Map<String, dynamic>? toJson(String? state) => { 'value': state };
}
