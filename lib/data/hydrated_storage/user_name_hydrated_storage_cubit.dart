import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:imagine/helper/helper.dart';

class UserNameHydratedStorageCubit extends HydratedCubit<String?>{
  UserNameHydratedStorageCubit() : super(null);

  setString(String userName) => emit(userName);
  clearData() => emit(null);

  @override
  String? fromJson(Map<String, dynamic> json) => json['value'] as String;

  @override
  Map<String, dynamic>? toJson(String? state) => { 'value': state };
}