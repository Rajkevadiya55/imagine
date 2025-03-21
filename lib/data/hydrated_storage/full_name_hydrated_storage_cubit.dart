import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:imagine/helper/helper.dart';

class FullNameHydratedStorageCubit extends HydratedCubit<String?>{
  FullNameHydratedStorageCubit() : super(null);

  setString(String fullName) => emit(fullName);
  clearData() => emit(null);

  @override
  String? fromJson(Map<String, dynamic> json) => json['value'] as String;

  @override
  Map<String, dynamic>? toJson(String? state) => { 'value': state };
}