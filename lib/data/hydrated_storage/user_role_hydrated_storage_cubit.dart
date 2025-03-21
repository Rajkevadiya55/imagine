import 'package:hydrated_bloc/hydrated_bloc.dart';

class UserRoleHydratedStorageCubit extends HydratedCubit<String?> {
  UserRoleHydratedStorageCubit() : super(null);

  setString(String role) => emit(role);
  clearData() => emit(null);

  @override
  String? fromJson(Map<String, dynamic> json) => json['value'] as String;

  @override
  Map<String, dynamic>? toJson(String? state) => { 'value': state };
}
