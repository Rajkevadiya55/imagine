import 'package:hydrated_bloc/hydrated_bloc.dart';

class IdHydratedStorageCubit extends HydratedCubit<String?> {
  IdHydratedStorageCubit() : super(null);

  setString(String ids) => emit(ids);
  clearData() => emit(null);

  @override
  String? fromJson(Map<String, dynamic> json) => json['value'] as String;

  @override
  Map<String, dynamic>? toJson(String? state) => { 'value': state };
}
