import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:imagine/main.dart';
import 'package:imagine/repositories/repository.dart';

/// Add app level repositories and cubits.
class BlocAndRepositoryApp extends StatelessWidget {
  const BlocAndRepositoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => Repository(),
          ),
        ],
        child: MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => UserIdHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => DeleteTaskHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => CreateTaskHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => ViewTaskHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => EditTaskHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => ViewAllTaskHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => UserRoleHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => FullNameHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => UserNameHydratedStorageCubit(),
          ),
          BlocProvider(
            create: (context) => IdHydratedStorageCubit(),
          ),
        ], child: const MyApp()));
  }
}
