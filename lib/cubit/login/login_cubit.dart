import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:imagine/data/http/http_data_provider/custom_http_exception.dart';
import 'package:imagine/data/hydrated_storage/create_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/delete_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/edit_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/full_name_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/id_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/user_id_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/user_name_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/user_role_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/view_all_task_hydrated_storage_cubit.dart';
import 'package:imagine/data/hydrated_storage/view_task_hydrated_storage_cubit.dart';
import 'package:imagine/helper/helper.dart';
import 'package:imagine/model/login/login_req_model.dart';
import 'package:imagine/model/login/login_res_model.dart';
import 'package:imagine/repositories/repository.dart';
import 'package:imagine/router/app_router.dart';
import 'package:imagine/widget/app_easy_loading.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository authRepository;
  final UserIdHydratedStorageCubit userIdHydratedStorageCubit;
  final DeleteTaskHydratedStorageCubit deleteTaskHydratedStorageCubit;
  final CreateTaskHydratedStorageCubit createTaskHydratedStorageCubit;
  final ViewTaskHydratedStorageCubit viewTaskHydratedStorageCubit;
  final EditTaskHydratedStorageCubit editTaskHydratedStorageCubit;
  final ViewAllTaskHydratedStorageCubit viewAllTaskHydratedStorageCubit;
  final UserRoleHydratedStorageCubit userRoleHydratedStorageCubit;
  final FullNameHydratedStorageCubit fullNameHydratedStorageCubit;
  final UserNameHydratedStorageCubit userNameHydratedStorageCubit;
  final IdHydratedStorageCubit idHydratedStorageCubit;

  LoginCubit(
    this.authRepository,
    this.userIdHydratedStorageCubit,
    this.deleteTaskHydratedStorageCubit,
    this.createTaskHydratedStorageCubit,
    this.viewTaskHydratedStorageCubit,
    this.editTaskHydratedStorageCubit,
    this.viewAllTaskHydratedStorageCubit,
    this.userRoleHydratedStorageCubit,
    this.fullNameHydratedStorageCubit,
    this.userNameHydratedStorageCubit,
    this.idHydratedStorageCubit,
  ) : super(LoginInitial());

  loginCubit({
    required String mobile,
    required String password,
  }) async {
    if (mobile.isEmpty) {
      easyLoadingShowError('Email address cannot be empty!.');
    } else if (password.isEmpty) {
      easyLoadingShowError('password can not be empty!.');
    } else {
      try {
        emit(LoginStateLoading());
        final request = LoginReqModel(mobile: mobile, password: password);
        final response = await authRepository.loginRepo(request);
        if (response.status!) {
          emit(
            LoginStateSuccess(message: response.message.toString()),
          );
          userIdHydratedStorageCubit.setString(response.user!.userId!);
          fullNameHydratedStorageCubit.setString(response.user!.fullName!);
          userNameHydratedStorageCubit.setString(response.user!.username!);
          idHydratedStorageCubit.setString(response.user!.id!);
          fullName = response.user!.fullName;
          userName = response.user!.username;
          userId = response.user!.userId;
          userRole = response.user!.userRole;
          id = response.user!.id;
          userRoleHydratedStorageCubit.setString(response.user!.userRole!);
          if (response.user!.userRole == 'user') {
            for (int i = 0; i < response.user!.permissions!.length; i++) {
              if (response.user!.permissions![i].permission! ==
                  'delete_tasks') {
                deleteTasks = response.user!.permissions![i].value!;
                deleteTaskHydratedStorageCubit
                    .setBool(response.user!.permissions![i].value!);
              } else if (response.user!.permissions![i].permission! ==
                  'create_tasks') {
                createTasks = response.user!.permissions![i].value!;
                createTaskHydratedStorageCubit
                    .setBool(response.user!.permissions![i].value!);
              } else if (response.user!.permissions![i].permission! ==
                  'view_tasks') {
                viewTasks = response.user!.permissions![i].value!;
                viewTaskHydratedStorageCubit
                    .setBool(response.user!.permissions![i].value!);
              } else if (response.user!.permissions![i].permission! ==
                  'edit_tasks') {
                editTasks = response.user!.permissions![i].value!;
                editTaskHydratedStorageCubit
                    .setBool(response.user!.permissions![i].value!);
              } else if (response.user!.permissions![i].permission! ==
                  'view_all_tasks') {
                viewAllTasks = response.user!.permissions![i].value!;
                viewAllTaskHydratedStorageCubit
                    .setBool(response.user!.permissions![i].value!);
              }
            }
          } else {}
        } else {
          emit(LoginStateError(response.message.toString()));
        }
      } catch (e) {
        print('errorr $e');
        if (e is CustomHttpException) {
          emit(LoginStateError(e.message));
        } else {
          emit(LoginStateError("Something went wrong!"));
        }
      }
    }
  }
}
