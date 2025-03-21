import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imagine/cubit/create_task/create_task_cubit.dart';
import 'package:imagine/cubit/dropdown/dropdown_cubit.dart';
import 'package:imagine/cubit/firebase_token/firebase_token_cubit.dart';
import 'package:imagine/cubit/login/login_cubit.dart';
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
import 'package:imagine/model/task_list/task_list_res_model.dart';
import 'package:imagine/repositories/repository.dart';
import 'package:imagine/view/create/create_task.dart';
import 'package:imagine/view/dashBoard/dash_board_view.dart';
import 'package:imagine/view/edite/edite_view.dart';
import 'package:imagine/view/login_view/login_view.dart';
import 'package:imagine/view/splash/splash_view.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static const String splash = "splash";
  static const String login = "login";
  static const String dashboard = "dashboard";
  static const String createTask = "createTask";
  static const String editeView = "editeView";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _splashNavigationScreen(settings);
      case login:
        return _loginNavigationScreen(settings);
      case dashboard:
        return _dashboardNavigationScreen(settings);
      case createTask:
        return _createTaskNavigationScreen(settings);
      case editeView:
        return _editeViewNavigationScreen(settings);
      default:
        throw Exception("Route We not found");
    }
  }

  static _splashNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => const SplashView());
  }

  static _createTaskNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DropdownCubit(context.read<Repository>()),
          ),
          BlocProvider(
            create: (context) => CreateTaskCubit(context.read<Repository>()),
          ),
        ],
        child: const CreateTask(),
      ),
    );
  }

  static _loginNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(
              context.read<Repository>(),
              context.read<UserIdHydratedStorageCubit>(),
              context.read<DeleteTaskHydratedStorageCubit>(),
              context.read<CreateTaskHydratedStorageCubit>(),
              context.read<ViewTaskHydratedStorageCubit>(),
              context.read<EditTaskHydratedStorageCubit>(),
              context.read<ViewAllTaskHydratedStorageCubit>(),
              context.read<UserRoleHydratedStorageCubit>(),
              context.read<FullNameHydratedStorageCubit>(),
              context.read<UserNameHydratedStorageCubit>(),
              context.read<IdHydratedStorageCubit>(),
            ),
          ),
          BlocProvider(
            create: (context) => FirebaseTokenCubit(
              context.read<Repository>(),
            ),
          ),
        ],
        child: const LoginView(),
      ),
    );
  }

  static _dashboardNavigationScreen(RouteSettings settings) {
    return MaterialPageRoute(builder: (context) => DashBoardView());
  }

  static _editeViewNavigationScreen(RouteSettings settings) {
    /*  final data = settings.arguments as Map<String, dynamic>?; // Ensure arguments are passed
    if (data == null) {
      throw Exception("Arguments for EditeView are required");
    }*/
    return MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DropdownCubit(context.read<Repository>()),
          ),
          BlocProvider(
            create: (context) => CreateTaskCubit(context.read<Repository>()),
          ),
        ],
        child: EditeView(
          data: settings.arguments as Data,
        ),
      ),
    );
  }
}
